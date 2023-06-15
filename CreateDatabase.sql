/* 

CREATING GLOBAL DATABASE STRUCTURE
Tables below are common to all Cinemas

*/

CREATE DATABASE IF NOT EXISTS cinema_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE cinema_db;



CREATE TABLE Cinemas(
    id INT(11) NOT NULL PRIMARY KEY,
    numberOfRooms INT(11) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
);

/*Users can be anonymous, therefor personnal attributes are optionnal, 
but anonymous users get an id*/
CREATE TABLE Users(
    id CHAR(36) PRIMARY KEY,
    email VARCHAR(50) UNIQUE,
    `password` VARCHAR(255)
);

/*Creating Films Table containing all films available in all cinemas*/
CREATE TABLE Films(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    `length` INT(11) NOT NULL
);


/*Creating Rates Table*/
CREATE TABLE Rates(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    /*Using Decimal with (4,2) to be able to calculate a price up to 9999.99, 
    might need to be changed if used with a currency using high numbers*/
    price DECIMAL(4,2) NOT NULL
);



/*

CREATING GLOBAL DATABASE ADMINISTRATORS

*/

CREATE USER 'global-admin1'@'%' IDENTIFIED BY 'aGreatP4ssw0rd';
GRANT ALL PRIVILEGES ON cinemas-db.* TO 'global-admin1'@'%';
FLUSH PRIVILEGES;

CREATE USER 'global-admin2'@'%' IDENTIFIED BY 'anoth3rGreatP4ssw0rd';
GRANT ALL PRIVILEGES ON cinemas-db.* TO 'global-admin2'@'%';
FLUSH PRIVILEGES;

/*

CREATING A CINEMA

*/
DECLARE @numberOfRooms INT;

SET @numberOfRooms = 7;
INSERT INTO Cinemas(id,  numberOfRooms, `name`)
VALUES( 1, @numberOfRooms, 'Cinéma Rathon' );

/*Creating all tables associated with  the Cinema*/

CREATE TABLE FilmsInCinema1(
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    id_film INT NOT NULL UNIQUE,
    FOREIGN KEY (id_film) REFERENCES Films(id)
);

CREATE TABLE Cinema1Rooms(
    roomNumber INT PRIMARY KEY UNIQUE,
    seats INT(11) NOT NULL
);

CREATE TABLE Cinema1Schedule(
    id INT AUTO_INCREMENT PRIMARY KEY,
    scheduledTime DATE NOT NULL UNIQUE,
);

CREATE TABLE Cinema1Screenings(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_film INT NOT NULL,
    id_scheduledTime INT NOT NULL,
    id_room INT NOT NULL,
    FOREIGN KEY (id_film) REFERENCES FilmsInCinema1(id),
    FOREIGN KEY (id_scheduledTime) REFERENCES Cinema1Schedule(id),
    FOREIGN KEY (id_room) REFERENCES Cinema1Rooms(id)
);

CREATE TABLE Cinema1Tickets(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_screening INT NOT NULL,
    id_user CHAR(36),
    id_rate INT NOT NULL,
);

/* CREATING ADMIN for Cinema 1*/

CREATE USER 'admin-cinema1'@'%' IDENTIFIED BY 'aTrueAdm1nPassw0rd';

/* Cinema admins can not delete or update Films Table because it is shared with other cinemas*/
GRANT SELECT, INSERT ON cinema_db.Films TO 'admin-cinema1'@'%';

GRANT ALL PRIVILEGES ON cinema_db.FilmsInCinema1 TO 'admin-cinema1'@'%';
GRANT ALL PRIVILEGES ON cinema_db.Cinema1Schedule TO 'admin-cinema1'@'%';
GRANT ALL PRIVILEGES ON cinema_db.Cinema1Screenings TO 'admin-cinema1'@'%';
GRANT ALL PRIVILEGES ON cinema_db.Cinema1Tickets TO 'admin-cinema1'@'%';

FLUSH PRIVILEGES;