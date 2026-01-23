-- =============================================================================
-- SCRIPT DE RÉINITIALISATION ET INSERTION DE DONNÉES (DROP/CREATE/INSERT)
-- =============================================================================

-- Suppression des tables existantes
DROP TABLE IF EXISTS payment_details_diffusion CASCADE;
DROP TABLE IF EXISTS payment_diffusion CASCADE;
DROP TABLE IF EXISTS diffusion_programmation CASCADE;
DROP TABLE IF EXISTS diffusion CASCADE;
DROP TABLE IF EXISTS tarif_pub CASCADE;
DROP TABLE IF EXISTS societe CASCADE;
DROP TABLE IF EXISTS remise_tarif CASCADE;
DROP TABLE IF EXISTS tarif_vol CASCADE;
DROP TABLE IF EXISTS historique_reservation CASCADE;
DROP TABLE IF EXISTS statut_reservation CASCADE;
DROP TABLE IF EXISTS reservation_place CASCADE;
DROP TABLE IF EXISTS type_passager CASCADE;
DROP TABLE IF EXISTS reservation CASCADE;
DROP TABLE IF EXISTS classe_place CASCADE;
DROP TABLE IF EXISTS classe CASCADE;
DROP TABLE IF EXISTS client CASCADE;
DROP TABLE IF EXISTS avion_pilote CASCADE;
DROP TABLE IF EXISTS vol_programmation_statut CASCADE;
DROP TABLE IF EXISTS vol_programmation CASCADE;
DROP TABLE IF EXISTS statut_vol CASCADE;
DROP TABLE IF EXISTS vol CASCADE;
DROP TABLE IF EXISTS pilote CASCADE;
DROP TABLE IF EXISTS aeroport CASCADE;
DROP TABLE IF EXISTS avion CASCADE;

-- =============================================================================
-- CRÉATION DES TABLES
-- =============================================================================

CREATE TABLE avion (
    id SERIAL PRIMARY KEY,
    matricule VARCHAR(50),
    capacite INTEGER
);

CREATE TABLE aeroport (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100)
);

CREATE TABLE pilote (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100)
);

CREATE TABLE vol (
    id SERIAL PRIMARY KEY,
    id_aeroport_depart INTEGER REFERENCES aeroport(id),
    id_aeroport_arrivee INTEGER REFERENCES aeroport(id),
    duree DECIMAL(5,2)
);

CREATE TABLE statut_vol (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE vol_programmation (
    id serial primary key,
    id_vol INTEGER REFERENCES vol(id),
    id_avion INTEGER REFERENCES avion(id),
    date_heure TIMESTAMP
);

CREATE TABLE vol_programmation_statut (
    id SERIAL PRIMARY KEY,
    id_vol_programmation INTEGER REFERENCES vol_programmation(id),
    id_statut INTEGER REFERENCES statut_vol(id),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE avion_pilote (
    id_avion INTEGER REFERENCES avion(id),
    id_pilote INTEGER REFERENCES pilote(id),
    date DATE,
    PRIMARY KEY (id_avion, id_pilote, date)
);

CREATE TABLE client (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    email VARCHAR(150),
    telephone VARCHAR(20)
);

CREATE TABLE classe (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE classe_place (
    id_classe INTEGER REFERENCES classe(id),
    place_debut INTEGER,
    place_fin INTEGER,
    id_avion INTEGER REFERENCES avion(id),
    PRIMARY KEY (id_classe, id_avion)
);

CREATE TABLE reservation (
    id SERIAL PRIMARY KEY,
    id_vol_programmation INTEGER REFERENCES vol_programmation(id),
    id_client INTEGER REFERENCES client(id),
    nombre_places INTEGER DEFAULT 1
);

CREATE TABLE type_passager (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE reservation_place (
    id_reservation INTEGER REFERENCES reservation(id),
    place INTEGER,
    id_type_passager INTEGER REFERENCES type_passager(id)
);

CREATE TABLE statut_reservation (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE historique_reservation (
    id SERIAL PRIMARY KEY,
    id_reservation INTEGER REFERENCES reservation(id),
    id_statut INTEGER REFERENCES statut_reservation(id),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tarif_vol (
    id SERIAL PRIMARY KEY,
    id_vol_programmation INTEGER REFERENCES vol_programmation(id),
    id_classe INTEGER REFERENCES classe(id),
    id_type_passager INTEGER REFERENCES type_passager(id),
    tarif DECIMAL(10,2)
);

CREATE TABLE remise_tarif (
    id SERIAL PRIMARY KEY,
    remise NUMERIC(10,2) NOT NULL,
    formule VARCHAR(10) NOT NULL,
    id_type_passager_appliquer INTEGER REFERENCES type_passager(id), 
    id_type_passager_reference INTEGER REFERENCES type_passager(id), 
    id_classe INTEGER REFERENCES classe(id),
    id_vol_programmation INTEGER REFERENCES vol_programmation(id)
);

CREATE TABLE societe (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

CREATE TABLE tarif_pub (
    id SERIAL PRIMARY KEY,
    montant DECIMAL(15,2) NOT NULL,
    date_application DATE NOT NULL
);

CREATE TABLE diffusion (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    id_societe INTEGER REFERENCES societe(id)
);

CREATE TABLE diffusion_programmation (
    id SERIAL PRIMARY KEY,
    id_diffusion INTEGER REFERENCES diffusion(id),
    id_vol_programmation INTEGER REFERENCES vol_programmation(id),
    nombre_diffusions INTEGER DEFAULT 1,
    date_programmation DATE NOT NULL
);

CREATE TABLE payment_diffusion (
    id SERIAL PRIMARY KEY,
    id_societe INTEGER REFERENCES societe(id),
    id_diffusion_programmation INTEGER REFERENCES diffusion_programmation(id)
);

CREATE TABLE payment_details_diffusion (
    id SERIAL PRIMARY KEY,
    id_payment INTEGER REFERENCES payment_diffusion(id),
    date_payment TIMESTAMP NOT NULL,
    montant DECIMAL(15,2) NOT NULL
);

-- =============================================================================
-- INSERTION DES DONNÉES
-- =============================================================================

-- 1. Aéroports
INSERT INTO aeroport (nom) VALUES ('TNR'), ('NSB');

-- 2. Avion
INSERT INTO avion (matricule, capacite) VALUES ('ATR-045', 72);

-- 3. Classes
INSERT INTO classe (nom) VALUES ('Économique');

-- 4. Types de passagers
INSERT INTO type_passager (nom) VALUES ('Adulte');

-- 5. Statuts
INSERT INTO statut_vol (nom) VALUES ('À l''heure'), ('Retardé'), ('Annulé'), ('Embarquement'), ('En vol'), ('Atterri'), ('En cours');
INSERT INTO statut_reservation (nom) VALUES ('En attente'), ('Confirmée'), ('Annulée'), ('Complétée'), ('En cours');

-- 6. Client (pour les réservations)
INSERT INTO client (nom, prenom, email, telephone) VALUES ('Client', 'Test', 'client.test@email.com', '0340000000');

-- 7. Sociétés de publicité
INSERT INTO societe (nom) VALUES ('Vainala'), ('Lewis'), ('Socobis'), ('Jejoo');

-- 8. Tarifs Publicité

-- 10. Vol (TNR - NSB)
INSERT INTO vol (id_aeroport_depart, id_aeroport_arrivee, duree) 
VALUES ((SELECT id FROM aeroport WHERE nom = 'TNR'), (SELECT id FROM aeroport WHERE nom = 'NSB'), 1.5);

-- 11. Vol Programmation (3 vols)
INSERT INTO vol_programmation (id_vol, id_avion, date_heure) VALUES 
((SELECT id FROM vol LIMIT 1), (SELECT id FROM avion WHERE matricule = 'ATR-045'), '2026-01-20 10:00:00'),
((SELECT id FROM vol LIMIT 1), (SELECT id FROM avion WHERE matricule = 'ATR-045'), '2026-01-21 10:00:00'),
((SELECT id FROM vol LIMIT 1), (SELECT id FROM avion WHERE matricule = 'ATR-045'), '2026-01-21 15:00:00');

-- 12. Configuration des places par classe pour l'avion ATR-045
INSERT INTO classe_place (id_classe, place_debut, place_fin, id_avion)
SELECT c.id, 1, 72, a.id FROM classe c, avion a WHERE c.nom = 'Économique' AND a.matricule = 'ATR-045';

-- 13. Tarifs Vol (Billet Adulte Économique = 800 000 Ar)
INSERT INTO tarif_vol (id_vol_programmation, id_classe, id_type_passager, tarif)
SELECT vp.id, c.id, tp.id, 800000
FROM vol_programmation vp, classe c, type_passager tp
WHERE c.nom = 'Économique' AND tp.nom = 'Adulte';

-- 14. Réservations (Tickets vendus)
-- Vol du 20 janv 10h (40 tickets)

