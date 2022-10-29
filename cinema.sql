-- ----------------------------------------------------------------------

-- Devoir effectué par :
    --  Alexandre
    --  Discord : Eau Tarie#5281
    --  Pseudo sur le serveur Discord de l'Afpa : Wikipédia (Eau Tarie / Alex)

-- SOMMAIRE EFFECTUÉ À LA LIGNE 14

-- ----------------------------------------------------------------------

-- ! Début du devoir sur la création d'une base de donnée SQL pour un CINÉMA ! --

--  Sommaire :
    --  -- I. CREATION DE LA DATABASE ( LIGNE 49 à 57 )

    --  -- II. CREATIONS DES MODELES DES TABLES ( LIGNE : 62 à 205 ) :
    --      -   1) ADMIN ( LIGNE : 64 à 74 )
    --      -   2) CINEMA ( LIGNE : 79 à 92 )
    --      -   3) CLIENT ( LIGNE : 97 à 107 )
    --      -   4) Movie ( LIGNE : 112 à 121 )
    --      -   5) Price ( LIGNE : 126 à 136 )
    --      -   6) Room ( LIGNE : 141 à 150 )
    --      -   7) Séance ( LIGNE : 155 à 169 )
    --      -   8) ORDERS ( LIGNE : 174 à 185 )
    --      -   9) RESERVATION ( LIGNE : 190 à 203 )
    --
    --  -- III. CREATION DES DONNEES ( LIGNE : 207 à 382 ) :
    --      -   1) ADMIN ( LIGNE : 208 à 219 )
    --      -   2) CINEMA ( LIGNE : 224 à 235 )
    --      -   3) CLIENT ( LIGNE : 240 à 251 )
    --      -   4) MOVIE ( LIGNE : 256 à 267 )
    --      -   5) PRICE ( LIGNE : 272 à 293 )
    --      -   6) ROOM ( LIGNE : 298 à 319 )
    --      -   7) SÉANCE ( LIGNE : 324 à 245 )
    --      -   8) ORDERS ( LIGNE : 350 à 365 )
    --      -   9) RESERVATION ( LIGNE : 370 à 381 )

    --  -- IV. JOINTURE DES TABLES ( LIGNE : 387 à 400 ) :
    --      -   1) ADMIN à CINEMA ( LIGNE : 389 à 390 )
    --      -   2) PRICE à MOVIE ( LIGNE : 391 à 392 )
    --      -   3) CINEMA à ROOM ( LIGNE : 393 à 394 )
    --      -   4) CINEMA à SEANCE ( LIGNE : 395 à 396 )
    --      -   5) CLIENT à ORDERS ( LIGNE : 397 à 398 )
    --      -   6) ORDERS à RESERVATION ( LIGNE : 399 à 400 )

-- Fin du SOMMAIRE

-- I. CREATION DATABASE CINEMA :


    DROP DATABASE IF EXISTS cinema;
    CREATE DATABASE cinema;

    USE cinema;

-- FIN CREATION DATABASE CINEMA

-- -----------------------------------------------------------------------
-- -----------------------------------------------------------------------

-- II. CREATION DES MODELES DES TABLES --

    -- Creation du modèle de la table ADMIN :

        CREATE TABLE admin (
            id INT PRIMARY KEY NOT NULL,
            nom VARCHAR(100) NOT NULL,
            prenom VARCHAR(100),
            pass VARCHAR(255) NOT NULL,
            sign_in_date VARCHAR(255) NOT NULL
        );

    -- Fin de la creation du modèle de la table ADMIN

    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------

    -- Creation du modèle de la table CINEMA :

        CREATE TABLE cinema (
            id INT PRIMARY KEY NOT NULL,
            nom_enseigne VARCHAR(100) NOT NULL,
            city VARCHAR(100),
            postal_code VARCHAR(6),
            room INT NOT NULL,
            sign_in_date VARCHAR(255),
            admin_key int,
                CONSTRAINT fkCinemaAdmin FOREIGN KEY(admin_key) REFERENCES admin(id)
        );

    -- Fin du modèle de la création de la table CINEMA

    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------

    -- Création de la table CLIENT :

        CREATE TABLE client (
            id INT PRIMARY KEY NOT NULL,
            nom VARCHAR(100) NOT NULL,
            prenom VARCHAR(100) NOT NULL,
            age INT,
            sign_in_date VARCHAR(255) NOT NULL
        );

    -- Fin création de la table CLIENT

    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------

    -- Creation du modèle de la table MOVIE :

        CREATE TABLE movie (
            id INT PRIMARY KEY NOT NULL,
            nom VARCHAR(100) NOT NULL,
            release_date VARCHAR(100) NOT NULL,
            category VARCHAR(100)
        );

    -- Fin création de la table MOVIE
    
    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------
    
    -- Creation du modèle de la table PRICE :

        CREATE TABLE price (
            id INT PRIMARY KEY NOT NULL,
            movie_id INT,
            customers_status VARCHAR(100) NOT NULL,
            ticket_price INT,
                CONSTRAINT fkPriceMovie FOREIGN KEY(movie_id) REFERENCES movie(id)
        );

    -- Fin création de la table PRICE
    
    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------
    
    -- Creation du modèle de la table ROOM :

        CREATE TABLE room (
            id INT PRIMARY KEY NOT NULL,
            cinema_id INT NOT NULL,
            places INT NOT NULL,
                CONSTRAINT fkRoomCinema FOREIGN KEY(cinema_id) REFERENCES cinema(id)
        );

    -- Fin création de la table ROOM
    
    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------
    
    -- Creation du modèle de la table SÉANCE :

        CREATE TABLE seance (
            id INT PRIMARY KEY NOT NULL,
            movie_id INT NOT NULL,
                CONSTRAINT fkMovie_ID_Room FOREIGN KEY(movie_id) REFERENCES movie(id),
            cinema_id INT NOT NULL,
                CONSTRAINT fkCinema_ID_Room FOREIGN KEY(cinema_id) REFERENCES cinema(id),
            diffused_date VARCHAR(255),
            diffused_hour VARCHAR(255) NOT NULL,
            room_id INT,
                CONSTRAINT fkRoom_ID_Room FOREIGN KEY(room_id) REFERENCES room(id)
        );

    -- Fin création de la table SÉANCE
    
    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------
    
    -- Creation du modèle de la table ORDER (66) :

        CREATE TABLE orders (
            id INT PRIMARY KEY NOT NULL,
            client_id INT,
                CONSTRAINT fkOrder_Client_id FOREIGN KEY(client_id) REFERENCES client(id),
            total VARCHAR(100) NOT NULL,
            statut VARCHAR(100),
            purchase_date VARCHAR(100) NOT NULL
        );

    -- Fin creation du modele de la table ORDER (66)

    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------
    
    -- Creation du modèle de la table RESERVATION :

        CREATE TABLE reservation (
            id INT PRIMARY KEY NOT NULL,
            order_id INT,
                CONSTRAINT fkReservation_Order_id FOREIGN KEY(order_id) REFERENCES orders(id),
            price_id INT,
                CONSTRAINT fkReservation_Price_Id FOREIGN KEY(price_id) REFERENCES price(id),
            seat INT,
            seance_id INT,
                CONSTRAINT fkReservation_Seance_Id FOREIGN KEY(seance_id) REFERENCES seance(id)
        );

    -- Fin création du modèle de la table RESERVATION

-- FIN DE LA CRÉATION DES MODELES DES TABLES

-- III. CREATION DES DONNEES
    --  Création des données ADMIN
        -- Admin n°1 :
            INSERT INTO admin (id, nom, prenom, pass, sign_in_date) VALUES (1, 'EAU', 'Tarie', 'e9837d47b610ee29399831f917791a44', '01/01/2000');
        -- Admin n°2 :
            INSERT INTO admin (id, nom, prenom, pass, sign_in_date) VALUES (2, 'EAU', 'Lympique', 'e9837d47b610ee29399831f911a44', '02/02/1996');
        -- Admin n°3 :
            INSERT INTO admin (id, nom, prenom, pass, sign_in_date) VALUES (3, 'EAU', 'dorat', 'e9837d47b610ee293f911a44', '03/03/1998');
        -- Admin n°4 :
            INSERT INTO admin (id, nom, prenom, pass, sign_in_date) VALUES (4, 'EAU', 'la bourde', 'e9837d47b610ee293f9144', '04/04/1999');
        -- Admin n°5 :
            INSERT INTO admin (id, nom, prenom, pass, sign_in_date) VALUES (5, 'EAU', 'pital', 'e9837d47b610ee293f9144', '05/05/1996');
    -- Fin création des données ADMIN

    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------

    -- Créations des données CINEMA
        -- Cinema n°1 :
            INSERT INTO cinema(id, nom_enseigne, city, postal_code, room, sign_in_date, admin_key) VALUES (1,'Eau-rageux', 'Paris', '75 000', '75','01/01/1996',1);
        -- Cinema n°2 :
            INSERT INTO cinema(id, nom_enseigne, city, postal_code, room, sign_in_date, admin_key) VALUES (2,'Eau-dyssée', 'Chartres', '28 000', '28','01/01/1996',2);
        -- Cinema n°3 :
            INSERT INTO cinema(id, nom_enseigne, city, postal_code, room, sign_in_date, admin_key) VALUES (3,'D-EAU-bby', 'Saint-Nazaire', '44 600', '44','01/01/1996',3);
        -- Cinema n°4 :
            INSERT INTO cinema(id, nom_enseigne, city, postal_code, room, sign_in_date, admin_key) VALUES (4,'C-EAU-missariat', 'Lille', '59 000', '59','01/01/1996',4);
        -- Cinema n°5 :
            INSERT INTO cinema(id, nom_enseigne, city, postal_code, room, sign_in_date, admin_key) VALUES (5,'Flamenkuch', 'Strasbourg', '67 000', '67','01/01/1996',5);
    -- Fin création des données CINEMA

    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------

    -- Création des données CLIENT
        -- Client n°1 :
            INSERT INTO client (id, nom, prenom, age, sign_in_date) VALUES (1, 'Pyr', 'EauMan', '28', '05/05/1996');
        -- Client n°2 :
            INSERT INTO client (id, nom, prenom, age, sign_in_date) VALUES (2, 'Pyr', 'eautechnique', '30', '05/05/2015');
        -- Client n°3 :
            INSERT INTO client (id, nom, prenom, age, sign_in_date) VALUES (3, 'Eau', 'dacieux', '18', '05/05/2000');
        -- Client n°4 :
            INSERT INTO client (id, nom, prenom, age, sign_in_date) VALUES (4, 'EAU', 'dace', '40', '05/05/1950');
        -- Client n°5 :
            INSERT INTO client (id, nom, prenom, age, sign_in_date) VALUES (5, 'EAU', 'Marie', '60', '05/05/2022');
    -- Fin des créations des données CLIENT

    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------

    -- Création des données MOVIE :
        -- Movie n°1 :
            INSERT INTO movie (id, nom, release_date, category) VALUES (1, 'Eau-cean Pacifique', '20/12/2022', 'Dr-EAU-le');
        -- Movie n°2
            INSERT INTO movie (id, nom, release_date, category) VALUES (2, 'Eau-cean Atlantique', '05/05/2022', 'Mel-eau-dramatique');
        -- Movie n°3 :
            INSERT INTO movie (id, nom, release_date, category) VALUES (3, 'Eau-cean Arctique', '01/01/2023', 'Mel-eau-dramatique');
        -- Movie n°4 :
            INSERT INTO movie (id, nom, release_date, category) VALUES (4, "Eau-dyssée d'Abe", '10/10/2022', 'Mel-eau-dramatique');
        -- Movie n°5 :
            INSERT INTO movie (id, nom, release_date, category) VALUES (5, 'Eau Marie, si tu savais', '06/01/2022', 'Mel-eau-drame');
    -- Fin de la création des données MOVIE

    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------

    -- Création des données PRICE :
        -- Price n°1 ( Full Price ) :
            INSERT INTO price (id, movie_id, customers_status, ticket_price) VALUES (1, 1, 'Adulte', 10);
        -- Price n°1 ( Student Price ) :
            INSERT INTO price (id, movie_id, customers_status, ticket_price) VALUES (2, 1, 'Etudiant', 5);
        -- Price n°2 ( Full Price ) :
            INSERT INTO price (id, movie_id, customers_status, ticket_price) VALUES (3, 2, 'Adulte', 50);
        -- Price n°2 ( Student Price ) :
            INSERT INTO price (id, movie_id, customers_status, ticket_price) VALUES (4, 2, 'Etudiant', 20);
        -- Price n°3 ( Full Price ) :
            INSERT INTO price (id, movie_id, customers_status, ticket_price) VALUES (5, 3, 'Adulte', 20);
        -- Price n°3( Student Price ) :
            INSERT INTO price (id, movie_id, customers_status, ticket_price) VALUES (6, 3, 'Etudiant', 15);
        -- Price n°4 ( Full Price ) :
            INSERT INTO price (id, movie_id, customers_status, ticket_price) VALUES (7, 4, 'Adulte', 60);
        -- Price n°4 ( Student Price ) :
            INSERT INTO price (id, movie_id, customers_status, ticket_price) VALUES (8, 4, 'Etudiant', 30);
        -- Price n°5 ( Full Price ) :
            INSERT INTO price (id, movie_id, customers_status, ticket_price) VALUES (9, 5, 'Adulte', 5);
        -- Price n°5 ( Student Price ) :
            INSERT INTO price (id, movie_id, customers_status, ticket_price) VALUES (10, 5, 'Etudiant', 2);
    -- Fin création des données PRICE
    
    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------

    -- Création des données ROOM :
        -- Room n°1 :
            INSERT INTO room (id, cinema_id, places) VALUES (1, 1, 75);
        -- Room n°2 :
            INSERT INTO room (id, cinema_id, places) VALUES (2, 2, 60);
        -- Room n°3 :
            INSERT INTO room (id, cinema_id, places) VALUES (3, 3, 55);
        -- Room n°4 :
            INSERT INTO room (id, cinema_id, places) VALUES (4, 4, 100);
        -- Room n°5 :
            INSERT INTO room (id, cinema_id, places) VALUES (5, 5, 20);
        -- Room n°6 :
            INSERT INTO room (id, cinema_id, places) VALUES (6, 5, 30);
        -- Room n°7 :
            INSERT INTO room (id, cinema_id, places) VALUES (7, 4, 40);
        -- Room n°8 :
            INSERT INTO room (id, cinema_id, places) VALUES (8, 3, 10);
        -- Room n°9 :
            INSERT INTO room (id, cinema_id, places) VALUES (9, 2, 5);
        -- Room n°10 :
            INSERT INTO room (id, cinema_id, places) VALUES (10, 1, 1);
    -- Fin création des données ROOM
    
    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------
    
    -- Création des données SEANCE :
        -- Séance n°1 :
            INSERT INTO seance (id, movie_id, cinema_id, diffused_date, diffused_hour, room_id) VALUES (1, 1, 1, "20 Sep 2022", "18 h 30", 1);
        -- Séance n°2 :
            INSERT INTO seance (id, movie_id, cinema_id, diffused_date, diffused_hour, room_id) VALUES (2, 2, 2, "30 Oct 2023", "20 h 30", 2);
        -- Séance n°3 :
            INSERT INTO seance (id, movie_id, cinema_id, diffused_date, diffused_hour, room_id) VALUES (3, 3, 3, "25 Sep 2021", "15 h 30", 3);
        -- Séance n°4 :
            INSERT INTO seance (id, movie_id, cinema_id, diffused_date, diffused_hour, room_id) VALUES (4, 4, 1, "03 Fev 2024", "10 h 30", 4);
        -- Séance n°5 :
            INSERT INTO seance (id, movie_id, cinema_id, diffused_date, diffused_hour, room_id) VALUES (5, 5, 5, "10 Jan 2025", "8 h 30", 5);
        -- Séance n°6 :
            INSERT INTO seance (id, movie_id, cinema_id, diffused_date, diffused_hour, room_id) VALUES (6, 5, 5, "22 Dec 2021", "23 h 30", 6);
        -- Séance n°7 :
            INSERT INTO seance (id, movie_id, cinema_id, diffused_date, diffused_hour, room_id) VALUES (7, 4, 4, "01 Apr 2020", "00 h 30", 7);
        -- Séance n°8 :
            INSERT INTO seance (id, movie_id, cinema_id, diffused_date, diffused_hour, room_id) VALUES (8, 3, 3, "30 June 2022", "18 h 30", 8);
        -- Séance n°9 :
            INSERT INTO seance (id, movie_id, cinema_id, diffused_date, diffused_hour, room_id) VALUES (9, 2, 2, "25 Aug 2023", "19 h 30", 9);
        -- Séance n°10 :
            INSERT INTO seance (id, movie_id, cinema_id, diffused_date, diffused_hour, room_id) VALUES (10, 1, 1, "15 Jully 2019", "20 h 30", 10);
    -- Fin création des données SEANCE 

    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------
    
    -- Création des données ORDERS :
        -- Orders n°1 :
            INSERT INTO orders (id, client_id, total, statut, purchase_date) VALUES (1,1, "100 euros", "Un-Paid", "---");
        -- Orders n°2 :
            INSERT INTO orders (id, client_id, total, statut, purchase_date) VALUES (2,2, "30 euros", "Paid and RESERVED", "20 Jun 2022");
        -- Orders n°3 :
            INSERT INTO orders (id, client_id, total, statut, purchase_date) VALUES (3,3, "50 euros", "Canceled", "---");
        -- Orders n°4 :
            INSERT INTO orders (id, client_id, total, statut, purchase_date) VALUES (4,4, "10 euros", "Paid", "01 FEV 2021");
        -- Orders n°5 :
            INSERT INTO orders (id, client_id, total, statut, purchase_date) VALUES (5,5, "200 euros", "Un-Paid", "25 Dec 2022");
        -- Orders n°6 :
            INSERT INTO orders (id, client_id, total, statut, purchase_date) VALUES (6,4, "500 euros", "Paid", "31 Fev 20550");
        -- Orders n°66 :
            INSERT INTO orders (id, client_id, total, statut, purchase_date) VALUES (66,3, "66 euros", "PAID and RESERVED", "19 av.BY / 3258 AL");
    -- Fin création des données ORDERS
    
    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------

    -- Création des donnees RESERVATION :
        -- Reservation n°1 :
            INSERT INTO reservation (id, order_id, price_id, seat, seance_id) VALUES (1, 1, 1, 30, 1);
        -- Reservation n°2 :
            INSERT INTO reservation (id, order_id, price_id, seat, seance_id) VALUES (2, 2, 2, 30, 2);
        -- Reservation n°3 :
            INSERT INTO reservation (id, order_id, price_id, seat, seance_id) VALUES (3, 3, 3, 30, 3);
        -- Reservation n°4 :
            INSERT INTO reservation (id, order_id, price_id, seat, seance_id) VALUES (4, 4, 1, 30, 4);
        -- Reservation n°5 :
            INSERT INTO reservation (id, order_id, price_id, seat, seance_id) VALUES (5, 5, 5, 30, 5);
    -- Fin creation des donnees RESERVATION
-- FIN CREATION DES DONNEES

    -- -----------------------------------------------------------------------
    -- -----------------------------------------------------------------------

-- IV. JOINTURE

    -- Jointure la table ADMIN à la table CINEMA :
        SELECT cinema.id, cinema.nom_enseigne, cinema.city, cinema.admin_key, admin.nom, admin.prenom FROM cinema INNER JOIN admin ON cinema.id=admin.id;
    -- Jointure la table PRICE à la table MOVIE :
        SELECT price.id, price.customers_status, price.ticket_price, movie.id, movie.nom, movie.release_date, movie.category FROM movie INNER JOIN price ON movie.id=price.id;
    -- Jointure de la table CINEMA à la table ROOM :
        SELECT room.id, room.places, cinema.id, cinema.nom_enseigne, cinema.city, cinema.postal_code FROM room INNER JOIN cinema ON room.id=cinema.id;
    -- Jointure de la table CINEMA à la table SEANCE :
        SELECT seance.id, seance.movie_id, seance.cinema_id, seance.diffused_date, seance.diffused_hour, seance.room_id, cinema.id, cinema.nom_enseigne FROM seance INNER JOIN cinema ON seance.id=cinema.id;
    -- Jointure de la table CLIENT à la table ORDERS :
        SELECT orders.id, orders.total, orders.statut, orders.purchase_date, orders.client_id, client.nom, client.prenom, client.sign_in_date FROM orders INNER JOIN client ON orders.id=client.id;
    -- Jointure de la table ORDERS à la table RESERVATION :
        SELECT reservation.id, reservation.price_id, reservation.seat, reservation.seance_id, reservation.order_id, orders.client_id, orders.total, orders.statut, orders.purchase_date FROM reservation INNER JOIN orders ON reservation.id=orders.id;
-- FIN DES JOINTURES