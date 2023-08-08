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