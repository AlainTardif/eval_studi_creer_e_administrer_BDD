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
