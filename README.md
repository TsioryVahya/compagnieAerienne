# Système de Gestion de Compagnie Aérienne

Ce projet est une application de gestion pour une compagnie aérienne, développée avec Spring Boot. Elle permet de gérer les vols, les réservations, les avions, les pilotes et les aéroports.

## 🚀 Technologies Utilisées

- **Java 17**
- **Spring Boot 4.0.1**
- **Spring Data JPA** : Pour la persistance des données.
- **PostgreSQL** : Base de données relationnelle.
- **JSP (JavaServer Pages)** : Pour l'interface utilisateur.
- **Lombok** : Pour réduire le code boilerplate.
- **Maven** : Gestionnaire de dépendances.

## 📁 Structure du Projet

Le projet suit une architecture classique en couches :

- `com.companieaerienne.controllers` : Gère les requêtes HTTP et les vues JSP.
- `com.companieaerienne.entities` : Modèles de données JPA.
- `com.companieaerienne.repositories` : Interfaces pour l'accès aux données.
- `com.companieaerienne.services` : Logique métier de l'application.
- `src/main/webapp/WEB-INF/jsp/` : Contient les pages de l'interface utilisateur.

## ⚙️ Configuration

### Base de données

1. Assurez-vous d'avoir **PostgreSQL** installé et en cours d'exécution.
2. Créez une base de données nommée `compagnieAerienne`.
3. Exécutez les scripts SQL situés dans le dossier `database/` pour initialiser le schéma et les données de test :
   - `database/base.sql` (Schéma)
   - `database/test-data.sql` (Données optionnelles)

### Application

Modifiez le fichier [application.properties](file:///w:/ITU/S5/GESTIONPROJET/companieAerienne/git/compagnieAerienne/src/main/resources/application.properties) si nécessaire pour correspondre à vos identifiants PostgreSQL :

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/compagnieAerienne
spring.datasource.username=votre_utilisateur
spring.datasource.password=votre_mot_de_porte
```

## 🛠️ Installation et Lancement

1. Clonez le dépôt.
2. Compilez le projet avec Maven :
   ```bash
   ./mvnw clean install
   ```
3. Lancez l'application :
   ```bash
   ./mvnw spring-boot:run
   ```
4. Accédez à l'application via votre navigateur à l'adresse : `http://localhost:8080`

## ✨ Fonctionnalités Principales

- **Gestion des Vols** : Création, programmation et suivi des statuts des vols.
- **Réservations** : Gestion des réservations clients et attribution des places par classe.
- **Gestion de la Flotte** : Suivi des avions et de leur capacité.
- **Ressources Humaines** : Gestion des pilotes et de leurs affectations.
- **Infrastructure** : Gestion des aéroports de départ et d'arrivée.

## 📊 Modèle de Données

L'application s'appuie sur plusieurs entités clés :
- `Vol` : Définit un trajet entre deux aéroports.
- `VolProgrammation` : Une occurrence spécifique d'un vol à une date donnée.
- `Avion` & `Pilote` : Ressources affectées aux vols programmés.
- `Client` & `Reservation` : Gestion de la clientèle et des ventes de places.
- `Classe` & `ClassePlace` : Segmentation des places dans l'avion (Économie, Business, etc.).
