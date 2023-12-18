# Coding-Game-Back

Application back-end Spring Boot pour 'Coding Game'. Cette application reçoit des appels REST avec des paramètres pour le code, le type de langage et le numéro de l'exercice. Selon ces paramètres, elle détermine le conteneur Docker approprié pour exécuter le code.

## Prérequis

- JDK 17
- Maven
- Docker

## Installation

Pour cloner et installer le projet :

```
git clone https://github.com/ziedbg/coding-game-back.git
cd coding-game-back
```

## Configuration

Aucune configuration spécifique n'est requise. Assurez-vous que Docker est installé et fonctionnel sur votre machine.

## Construction et Lancement
### Avec Maven
Pour construire et lancer l'application :
``` 
mvn clean install
java -jar target/coding-game-back-0.0.1-SNAPSHOT.jar
```
### Avec Docker
Construisez l'image Docker et lancez le conteneur :
``` 
docker build -t coding-game-back .
docker run -p 8080:8080 coding-game-back
```
## Utilisation
Faites des appels REST à l'application. Par exemple, pour envoyer une requête :
``` 
GET http://localhost:8080/greeting?name=World
```
Cette requête renverra un message de salutation.

## Tests
Pour exécuter les tests :
``` 
mvn test
```
## Déploiement
Le déploiement peut être effectué en construisant une image Docker et en la déployant dans votre environnement de choix.

## Contribution
Les contributions sont les bienvenues. Veuillez soumettre vos pull requests sur GitHub.

## Licence
Ce projet est la propriété privée de I-Lead-Consulting. Tous droits réservés.
