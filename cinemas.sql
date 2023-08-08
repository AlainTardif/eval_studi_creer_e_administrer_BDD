-- je me connecte à MySQL en ligne de commande
mysql -u root -p

-- je saisi mon mot de passe, la console affiche : MariaDB[(none)]>

-- je vérifie les bases de données existantes avec la cde
SHOW databases;

-- je crée la BDD cinemas
CREATE DATABASE IF NOT EXISTS cinemas CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;