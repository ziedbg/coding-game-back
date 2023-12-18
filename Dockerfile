# Etape 1: Utiliser une image de base Alpine Java légère
FROM openjdk:17-jdk-alpine as builder

# Copier le JAR de l'application dans l'image et extraire ses couches
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract

# Etape 2: Construire l'image finale avec les couches extraites
FROM openjdk:17-jdk-alpine

# Créer un utilisateur et un groupe 'spring' pour exécuter l'application
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copier les couches extraites du builder
COPY --from=builder dependencies/ ./
COPY --from=builder snapshot-dependencies/ ./
COPY --from=builder spring-boot-loader/ ./
COPY --from=builder application/ ./

# Exposer le port sur lequel votre application s'exécute
EXPOSE 8080

# Définir des variables d'environnement pour la JVM
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

# Health check pour surveiller l'état de l'application
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/actuator/health || exit 1

# La commande pour exécuter l'application
ENTRYPOINT ["java","-cp",".","org.springframework.boot.loader.launch.JarLauncher"]

