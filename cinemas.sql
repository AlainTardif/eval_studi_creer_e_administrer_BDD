-- je me connecte à MySQL en ligne de commande
mysql -u root -p

-- je saisi mon mot de passe, la console affiche : MariaDB[(none)]>

-- je vérifie les bases de données existantes avec la cde
SHOW databases;

-- je crée la BDD cinemas
CREATE DATABASE IF NOT EXISTS cinemas CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- je me connecte à ma BDD cinemas avec la cde 
USE cinemas;

-- je crée un administrateur avec tous les droits
CREATE USER 'admin3'@'localhost' IDENTIFIED BY 'kyxfJc4N3yqS';
GRANT ALL PRIVILEGES ON * . * TO 'admin3'@'localhost';

-- je crée un utilisateur avec vue sur les données uniquement
CREATE USER 'user3'@'localhost' IDENTIFIED BY 'ZqBpw5mqs3Ge';
GRANT SELECT ON * . * TO 'user3'@'localhost';

-- je crée mes tables : la première multiplex
-- Table Multiplex
CREATE TABLE IF NOT EXISTS multiplex
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(50) NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table User
CREATE TABLE IF NOT EXISTS user
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    role ENUM('admin', 'user') NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table Cinema
CREATE TABLE cinema (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(250) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    zip_code VARCHAR(5) NOT NULL,
    email VARCHAR(100) UNIQUE,
    country VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    IDMultiplex INT NOT NULL,
    IDUser INT NOT NULL,
    FOREIGN KEY (IDMultiplex) REFERENCES multiplex(id),
    FOREIGN KEY (IDUser) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table Movie
CREATE TABLE IF NOT EXISTS Movie
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    duration TIME,
    description TEXT,
    created_at DATETIME NOT NULL,
    updated_at DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table MovieRoom
CREATE TABLE IF NOT EXISTS MovieRoom
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    numbers_of_places INT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    IDCinema INT NOT NULL,
    FOREIGN KEY (IDCinema) REFERENCES Cinema(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table MovieSession
CREATE TABLE IF NOT EXISTS MovieSession
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    duration TIME NOT NULL,
    IDMovieRoom INT NOT NULL,
    IDMovie INT NOT NULL,
    FOREIGN KEY (IDMovieRoom) REFERENCES MovieRoom(id),
    FOREIGN KEY (IDMovie) REFERENCES Movie(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table Customer
CREATE TABLE IF NOT EXISTS Customer
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    login VARCHAR(50),
    password VARCHAR(50),
    created_at DATETIME NOT NULL,
    updated_at DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table PriceList
CREATE TABLE IF NOT EXISTS PriceList
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    study DECIMAL(5,2) NOT NULL,
    less_than_14 DECIMAL(5,2) NOT NULL,
    full_price DECIMAL(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table PriceReservation
CREATE TABLE IF NOT EXISTS PriceReservation
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    TTC DECIMAL NOT NULL,
    VAT DECIMAL NOT NULL,
    HT DECIMAL NOT NULL,
    numbers_of_places INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table Reservation
CREATE TABLE IF NOT EXISTS Reservation
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    numbers_of_places INT NOT NULL,
    taxe DECIMAL NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    IDPriceReservation INT NOT NULL,
    IDMovieSession INT NOT NULL,
    IDPriceList INT NOT NULL,
    IDCustomer INT NOT NULL,
    FOREIGN KEY (IDPriceReservation) REFERENCES PriceReservation(id),
    FOREIGN KEY (IDMovieSession) REFERENCES MovieSession(id),
    FOREIGN KEY (IDPriceList) REFERENCES PriceList(id),
    FOREIGN KEY (IDCustomer) REFERENCES Customer(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- j'insère des données pour la simulation et les tests pour mes tables
-- Insertion des données dans la table 'multiplex'

INSERT INTO multiplex (group_name) VALUES ('Multiplex Cinemas');

-- Insertion des données dans la table 'user'

INSERT INTO user (last_name, first_name, email, phone, role, created_at, updated_at) VALUES 
('Smith', 'John', 'john.smith@example.com', '1234567890', 'admin', NOW(), NOW()),
('Doe', 'Jane', 'jane.doe@example.com', '1234567891', 'user', NOW(), NOW()),
('Brown', 'Chris', 'chris.brown@example.com', '1234567892', 'user', NOW(), NOW()),
('Johnson', 'Emily', 'emily.johnson@example.com', '1234567893', 'admin', NOW(), NOW()),
('Davis', 'Sara', 'sara.davis@example.com', '1234567894', 'user', NOW(), NOW()),
('Miller', 'James', 'james.miller@example.com', '1234567895', 'admin', NOW(), NOW());

-- Insertion des données dans la table 'cinema'

INSERT INTO cinema (name, address, phone, zip_code, email, country, created_at, updated_at, IDMultiplex, IDUser) VALUES 
('Cinema 1', '123 Main St', '1234567890', '12345', 'cinema1@example.com', 'France', NOW(), NOW(), 1, 1),
('Cinema 2', '456 Main St', '1234567891', '12345', 'cinema2@example.com', 'France', NOW(), NOW(), 1, 2),
('Cinema 3', '789 Main St', '1234567892', '12345', 'cinema3@example.com', 'France', NOW(), NOW(), 1, 3),
('Cinema 4', '321 Main St', '1234567893', '12345', 'cinema4@example.com', 'France', NOW(), NOW(), 1, 4),
('Cinema 5', '654 Main St', '1234567894', '12345', 'cinema5@example.com', 'France', NOW(), NOW(), 1, 5),
('Cinema 6', '987 Main St', '1234567895', '12345', 'cinema6@example.com', 'France', NOW(), NOW(), 1, 6);

-- Insertion des données dans la table 'Movie'

INSERT INTO Movie (title, duration, description, created_at, updated_at) VALUES
('Dune', '02:35', 'Adaptation du roman de science-fiction de Frank Herbert, Dune explore l''histoire de la famille Atreides et la planète Arrakis.', NOW(), NOW()),
('No Time to Die', '02:43', 'Le dernier opus de James Bond, où l''agent 007 sort de sa retraite pour affronter un nouveau méchant.', NOW(), NOW()),
('Black Widow', '02:14', 'Le film solo de Natasha Romanoff, explorant son passé et ses aventures entre les films "Civil War" et "Infinity War".', NOW(), NOW()),
('Shang-Chi and the Legend of the Ten Rings', '02:12', 'Shang-Chi doit faire face à un passé qu''il croyait avoir laissé derrière lui lorsqu''il est attiré dans la toile de l''organisation des Dix Anneaux.', NOW(), NOW()),
('The French Dispatch', '01:47', 'Un film d''anthologie du réalisateur Wes Anderson, racontant des histoires tirées du dernier numéro d''un magazine américain publié dans une ville française fictive.', NOW(), NOW()),
('The Green Knight', '02:10', 'Un film de fantaisie épique qui raconte l''histoire de Sir Gawain et son défi face au mystérieux Chevalier Vert.', NOW(), NOW());

-- Insertion des données dans la table 'MovieRoom'

INSERT INTO MovieRoom (name, numero, numbers_of_places, created_at, updated_at, IDCinema) VALUES
('Salle 1', 1, 100, NOW(), NOW(), 1),
('Salle 2', 2, 150, NOW(), NOW(), 2),
('Salle 3', 3, 200, NOW(), NOW(), 3),
('Salle 4', 4, 250, NOW(), NOW(), 4),
('Salle 5', 5, 300, NOW(), NOW(), 5),
('Salle 6', 6, 350, NOW(), NOW(), 6);


-- Insertion des données dans la table 'MovieSession'

INSERT INTO MovieSession (date, start_time, end_time, duration, IDMovieRoom, IDMovie) VALUES
('2023-09-01', '18:00', '20:00', '02:00', 1, 1),
('2023-09-02', '19:00', '20:45', '01:45', 2, 2),
('2023-09-03', '20:00', '21:30', '01:30', 3, 3),
('2023-09-04', '21:00', '23:15', '02:15', 4, 4),
('2023-09-05', '22:00', '23:50', '01:50', 5, 5),
('2023-09-06', '23:00', '01:05', '02:05', 6, 6);

-- Insertion des données dans la table 'PriceReservation'

INSERT INTO PriceReservation (TTC, VAT, HT, numbers_of_places) VALUES
(12.00, 2.00, 10.00, 1),
(24.00, 4.00, 20.00, 2),
(36.00, 6.00, 30.00, 3),
(48.00, 8.00, 40.00, 4),
(60.00, 10.00, 50.00, 5),
(72.00, 12.00, 60.00, 6);

-- Insertion des données dans la table 'PriceList'

INSERT INTO PriceList (study, less_than_14, full_price) VALUES
(8.00, 6.00, 10.00);


-- Insertion des données dans la table 'Customer'

INSERT INTO Customer (last_name, first_name, email, phone, login, password, created_at, updated_at) VALUES
('Smith', 'John', 'john.smith@example.com', '1234567890', 'johnsmith', 'password1', NOW(), NOW()),
('Doe', 'Jane', 'jane.doe@example.com', '0987654321', 'janedoe', 'password2', NOW(), NOW()),
('Johnson', 'James', 'james.johnson@example.com', '1122334455', 'jamesjohnson', 'password3', NOW(), NOW()),
('Brown', 'Emily', 'emily.brown@example.com', '2233445566', 'emilybrown', 'password4', NOW(), NOW()),
('Davis', 'Michael', 'michael.davis@example.com', '3344556677', 'michaeldavis', 'password5', NOW(), NOW()),
('Taylor', 'Sarah', 'sarah.taylor@example.com', '4455667788', 'sarahtaylor', 'password6', NOW(), NOW());

-- Insertion des données dans la table 'Reservation'

INSERT INTO Reservation (numbers_of_places, taxe, created_at, updated_at, IDPriceReservation, IDMovieSession, IDPriceList, IDCustomer) VALUES
(1, 2.00, NOW(), NOW(), 1, 1, 1, 1),
(2, 4.00, NOW(), NOW(), 2, 2, 1, 2),
(3, 6.00, NOW(), NOW(), 3, 3, 1, 3),
(4, 8.00, NOW(), NOW(), 4, 4, 1, 4),
(5, 10.00, NOW(), NOW(), 5, 5, 1, 5),
(6, 12.00, NOW(), NOW(), 6, 6, 1, 6);

-- j'exécute les tests CRUD 

-- Sur la table Movie
-- 1 - CREATION : ajout d'un nouveau film
INSERT INTO Movie (title, duration, description, created_at, updated_at) 
VALUES ('Space Odyssey', '02:45:00', 'A journey through space and time', NOW(), NOW());
-- je vérifie si le film à bien été ajouté
SELECT title, duration, description FROM Movie WHERE title = 'Space Odyssey';

-- 2 - READ : je vérifie la lecture du film
SELECT title, duration, description FROM Movie WHERE title = 'Space Odyssey';

-- 3 - UPDATE : je modifie les détails du film
UPDATE Movie SET description = 'A thrilling journey through space and time' WHERE title = 'Space Odyssey';
-- je vérifie la mise à jour avec la cde
SELECT title, duration, description FROM Movie WHERE title = 'Space Odyssey';

-- 4 - DELETE : je supprime le film 
DELETE FROM Movie WHERE title = 'Space Odyssey';
-- je vérifie si le film à bien été supprimé
SELECT title, duration, description FROM Movie WHERE title = 'Space Odyssey';

-- Table User
-- 1 - CREATION : je crée un nouvel utilisateur
INSERT INTO User (last_name, first_name, email, phone, role, created_at, updated_at)
VALUES ('Taylor', 'Emily', 'emily.taylor@example.com', '1234567890', 'user', NOW(), NOW());
-- je vérifie si l'utilisateur à bien été ajouté
SELECT * FROM User WHERE email = 'emily.taylor@example.com';

-- 2 - READ : je vérifie la lecture de l'utilisateur
SELECT last_name, first_name, email, role FROM User WHERE email = 'emily.taylor@example.com';

-- 3 - UPDATE : je modifie les détails de l'utilisateur
UPDATE User SET phone = '0987654321' WHERE email = 'emily.taylor@example.com';
-- je vérifie la mise à jour avec la cde
SELECT * FROM User WHERE email = 'emily.taylor@example.com';

-- 4 - DELETE : je supprime l'utilisateur
DELETE FROM User WHERE email = 'emily.taylor@example.com';
-- je vérifie si l'utilisateur à bien été supprimé
SELECT * FROM User WHERE email = 'emily.taylor@example.com';

-- Table Cinema
-- 1 - CREATION : je crée un nouveau cinéma
INSERT INTO cinema (name, address, phone, zip_code, email, country, created_at, updated_at, IDMultiplex, IDUser)
VALUES ('City Cinema', '123 Main St', '1234567890', '10001', 'info@citycinema.com', 'France', NOW(), NOW(), 1, 1);

-- 2 - READ : je vérifie la lecture du nouveau cinéma
SELECT * FROM cinema WHERE name = 'City Cinema';

-- 3 - UPDATE : je modifie les détails du cinéma
UPDATE cinema SET phone = '0987654321' WHERE name = 'City Cinema';
-- je vérifie la mise à jour avec la cde
SELECT * FROM cinema WHERE name = 'City Cinema';

-- 4 - DELETE : je supprime le nouveau cinéma
DELETE FROM cinema WHERE name = 'City Cinema';
-- je vérifie si le cinéma à bien été supprimé
SELECT * FROM cinema WHERE name = 'City Cinema'; -- Doit retourner un résultat vide

-- Table MovieRoom
-- 1 - CREATION : je crée un nouveau MovieRoom
INSERT INTO MovieRoom (name, numero, numbers_of_places, created_at, updated_at, IDCinema)
VALUES ('Salle A', 1, 100, NOW(), NOW(), 1);
-- je vérifie si le MovieRoom à bien été ajouté
SELECT * FROM MovieRoom WHERE name = 'Salle A';

-- 2 - READ : je vérifie la lecture du nouveau MovieRoom
SELECT * FROM MovieRoom WHERE name = 'Salle A';

-- 3 - UPDATE : je modifie les détails du MovieRoom
UPDATE MovieRoom SET numbers_of_places = 120 WHERE name = 'Salle A';
-- je vérifie si le MovieRoom à bien été modifié
SELECT * FROM MovieRoom WHERE name = 'Salle A';

-- 4 - DELETE : je supprime le MovieRoom
DELETE FROM MovieRoom WHERE name = 'Salle A';
-- je vérifie si le MovieRoom à bien été supprimé
SELECT * FROM MovieRoom WHERE name = 'Salle A'; -- Doit retourner un résultat vide


-- Table MovieSession
-- 1 - CREATION : je crée une nouvelle MovieSession
INSERT INTO MovieSession (date, start_time, end_time, duration, IDMovieRoom, IDMovie)
VALUES ('2023-08-01', '14:00', '16:00', '02:00', 1, 1);

-- 2 - READ : je vérifie la lecture de MovieSession
SELECT * FROM MovieSession WHERE date = '2023-08-01' AND start_time = '14:00';

-- 3 - UPDATE : je modifie les détails de MovieSession
UPDATE MovieSession SET end_time = '16:30' WHERE date = '2023-08-01' AND start_time = '14:00';
-- je vérifie si le MovieSession à bien été modifié
SELECT * FROM MovieSession WHERE date = '2023-08-01' AND start_time = '14:00';

-- 4 - DELETE : je supprime la MovieSession
DELETE FROM MovieSession WHERE date = '2023-08-01' AND start_time = '14:00';
-- je vérifie si le MovieSession à bien été supprimé
SELECT * FROM MovieSession WHERE date = '2023-08-01' AND start_time = '14:00'; -- Doit retourner un résultat vide

-- Table Customer
-- 1 - CREATE: je crée un nouveau client dans la base de données Customer
INSERT INTO Customer (last_name, first_name, email, phone, login, password, created_at)
VALUES ('Doe', 'John', 'john.doe@example.com', '123-456-7890', 'johndoe', 'password123', NOW());

-- 2 - READ: je Lis les informations du client existant
SELECT * FROM Customer WHERE email = 'john.doe@example.com';

-- 3 - UPDATE: je Modifie les informations du client existant
UPDATE Customer
SET phone = '098-765-4321', updated_at = NOW()
WHERE email = 'john.doe@example.com';
-- je vérifie que les modifs sont bien effectuées
SELECT * FROM Customer WHERE email = 'john.doe@example.com';

-- 4 - DELETE: je supprime le client existant
DELETE FROM Customer WHERE email = 'john.doe@example.com';

-- je vérifie si le client à bien été supprimé (vide)
SELECT * FROM Customer WHERE email = 'john.doe@example.com';

-- Table PriceList
-- 1 - CREATE: j'insère un nouveau tarif dans la base de données
INSERT INTO PriceList (study, less_than_14, full_price)
VALUES (8.50, 6.00, 11.50);

-- 2 - READ: je lis les informations du tarif existant
SELECT * FROM PriceList WHERE study = 8.50;

-- 3 - UPDATE: je modifie les informations du tarif existant
UPDATE PriceList
SET full_price = 12.00
WHERE study = 8.50;
-- je vérifie si les modifs ont bien été effectuées
SELECT * FROM PriceList WHERE study = 8.50;

-- 4 - DELETE: je supprime le tarif existant
DELETE FROM PriceList WHERE study = 8.50;
-- je vérifie si le tarif à bien été supprimé
SELECT * FROM PriceList WHERE study = 8.50;

-- Table Reservation
-- 1 - CREATE: j'insère une nouveelle réservation dans la base de données
INSERT INTO Reservation (numbers_of_places, taxe, created_at, IDPriceReservation, IDMovieSession, IDPriceList, IDCustomer)
VALUES (5, 2.50, NOW(), 1, 1, 1, 1);

-- 2 - READ: je lis les informations de la réservation existante
SELECT * FROM Reservation WHERE numbers_of_places = 5;

-- 3 - UPDATE: je modifie les informations de la réservation existante
UPDATE Reservation
SET numbers_of_places = 6
WHERE numbers_of_places = 5;
-- je vérifie si les modifs ont bien été effectuées
SELECT * FROM Reservation WHERE numbers_of_places = 6;

-- 4 - DELETE: je supprime la réservation existante
DELETE FROM Reservation WHERE numbers_of_places = 6;

-- -- je vérifie si la réservation à bien été supprimé (vide)
SELECT * FROM Reservation WHERE numbers_of_places = 6;

-- Table PriceReservation
-- 1 - CREATE: j'insère une nouvelle réservation de prix dans la base de données
INSERT INTO PriceReservation (TTC, VAT, HT, numbers_of_places)
VALUES (15.00, 2.50, 12.50, 5);

-- 2 - READ: je lis les informations du prix de la nouvelle réservation 
SELECT * FROM PriceReservation WHERE TTC = 15.00;

-- 3 - UPDATE: je modifie les informations du prix de la réservation
UPDATE PriceReservation
SET TTC = 16.00
WHERE TTC = 15.00;
-- je vérifie si les modifs ont bien été effectuées
SELECT * FROM PriceReservation WHERE TTC = 16.00;

-- 4 - DELETE: je supprime le prix de la réservation
DELETE FROM PriceReservation WHERE TTC = 16.00;
-- -- je vérifie si le prix à bien été supprimé
SELECT * FROM PriceReservation WHERE TTC = 16.00;


-- Liste des films programmés pas dans tous les cinéma pour le (01.09.2023)
SELECT m.title, ms.start_time, ms.end_time
FROM Movie m
JOIN MovieSession ms ON m.id = ms.IDMovie
WHERE DATE(ms.date) = '2023-09-01';

-- Liste des films projetés dans un cinéma
SELECT m.title, ms.start_time, ms.end_time, c.name AS cinema_name
FROM Movie m
JOIN MovieSession ms ON m.id = ms.IDMovie
JOIN MovieRoom mr ON ms.IDMovieRoom = mr.id
JOIN Cinema c ON mr.IDCinema = c.id
WHERE DATE(ms.date) = '2023-09-10'
AND c.name = 'Cinema 1';

-- Liste des films projetés dans un cinéma avec heures des séances
SELECT m.title, ms.start_time, ms.end_time, c.name AS cinema_name
FROM Movie m
JOIN MovieSession ms ON m.id = ms.IDMovie
JOIN MovieRoom mr ON ms.IDMovieRoom = mr.id
JOIN Cinema c ON mr.IDCinema = c.id
WHERE DATE(ms.date) = '2023-08-24'
AND c.name = 'Cinema 4';

-- Liste des places réservés par des clients dans un cinéma
SELECT 
    r.id AS reservation_id,
    c.name AS cinema_name,
    m.title AS movie_title,
    mr.name AS room_name,
    ms.start_time,
    ms.end_time,
    r.numbers_of_places AS reserved_places,
    cu.last_name AS customer_last_name,
    cu.first_name AS customer_first_name
FROM Reservation r
JOIN MovieSession ms ON r.IDMovieSession = ms.id
JOIN MovieRoom mr ON ms.IDMovieRoom = mr.id
JOIN Cinema c ON mr.IDCinema = c.id
JOIN Movie m ON ms.IDMovie = m.id
JOIN Customer cu ON r.IDCustomer = cu.id
WHERE c.name = 'Cinema 3';

-- Calculer le nbe de places restantes dans un cinéma spécifique pour une date daonnée
SELECT
    m.title AS movie_title,
    r.name AS room_name,
    s.date AS session_date,
    s.start_time AS session_start_time,
    (r.numbers_of_places - IFNULL(SUM(res.numbers_of_places), 0)) AS remaining_places
FROM
    MovieRoom r
JOIN
    Cinema c ON c.id = r.IDCinema
JOIN
    MovieSession s ON s.IDMovieRoom = r.id
JOIN
    Movie m ON m.id = s.IDMovie
LEFT JOIN
    Reservation res ON res.IDMovieSession = s.id
WHERE
    c.id = 1 -- ID du cinéma spécifique
AND
    s.date = '2023-08-24' -- Date spécifique
GROUP BY
    m.id,
    r.id,
    s.id;
