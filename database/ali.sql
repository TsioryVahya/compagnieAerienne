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
