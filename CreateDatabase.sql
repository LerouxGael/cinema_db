/* 

CREATING GLOBAL DATABASE STRUCTURE
Tables below are common to all Cinemas

*/

CREATE DATABASE IF NOT EXISTS cinema_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE cinema_db;



CREATE TABLE Cinemas(
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numberOfRooms INT(11) NOT NULL,
    cinemaName VARCHAR(50) NOT NULL
);

/*Users can be anonymous, therefore personnal attributes are optionnal, 
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
GRANT ALL PRIVILEGES ON `cinemas-db`.* TO 'global-admin1'@'%';
FLUSH PRIVILEGES;

CREATE USER 'global-admin2'@'%' IDENTIFIED BY 'anoth3rGreatP4ssw0rd';
GRANT ALL PRIVILEGES ON `cinemas-db`.* TO 'global-admin2'@'%';
FLUSH PRIVILEGES;



/* CREATING a STORED PROCEDURE to create a new cinema and all tables associated*/

DELIMITER //

CREATE PROCEDURE new_cinema(IN cinema_name VARCHAR(255), IN number_of_rooms INT(11))
BEGIN
    DECLARE cinema_id INT;
    DECLARE room_table_name VARCHAR(255);
    DECLARE film_table_name VARCHAR(255);
    DECLARE schedule_table_name VARCHAR(255);
    DECLARE screenings_table_name VARCHAR(255);
    DECLARE tickets_table_name VARCHAR(255);
    DECLARE create_table_query VARCHAR(1000);
    DECLARE create_user_query VARCHAR(1000);
    DECLARE user_name VARCHAR(255);
    DECLARE admin_pass VARCHAR(255);
    
    /*Insert new Cinema*/
    INSERT INTO Cinemas (cinemaName, numberOfRooms) VALUES (cinema_name, number_of_rooms);

    SET cinema_id = LAST_INSERT_ID();
    SET room_table_name = CONCAT('RoomsCinema',cinema_id);

    /*Creating table for cinema rooms*/
    SET create_table_query = CONCAT('CREATE TABLE ', room_table_name, ' (roomNumber INT(11) PRIMARY KEY, seats INT(11) NOT NULL)');
    PREPARE create_table_stmt FROM create_table_query;
    EXECUTE create_table_stmt;
    DEALLOCATE PREPARE create_table_stmt;

    SET film_table_name = CONCAT('FilmsInCinema',cinema_id);
    SET create_table_query = CONCAT('CREATE TABLE ', film_table_name, ' (id INT AUTO_INCREMENT PRIMARY KEY, id_film INT NOT NULL UNIQUE, FOREIGN KEY (id_film) REFERENCES Films(id))');
    PREPARE create_table_stmt FROM create_table_query;
    EXECUTE create_table_stmt;
    DEALLOCATE PREPARE create_table_stmt;

    /* --Creating table for the cinema's Schedule */
    SET schedule_table_name = CONCAT('ScheduleCinema', cinema_id);
    SET create_table_query = CONCAT('CREATE TABLE ', schedule_table_name, ' (id INT AUTO_INCREMENT PRIMARY KEY, scheduledTime DATE NOT NULL UNIQUE)');
    PREPARE create_table_stmt FROM create_table_query;
    EXECUTE create_table_stmt;
    DEALLOCATE PREPARE create_table_stmt;

    /* --Creating table for the cinema's Screenings (film in a specific room, at a specific time) */
    SET screenings_table_name = CONCAT('ScreeningsCinema', cinema_id);
    SET create_table_query = CONCAT('CREATE TABLE ', screenings_table_name, ' (id INT AUTO_INCREMENT PRIMARY KEY, id_film INT NOT NULL, id_schedule INT NOT NULL, id_room INT NOT NULL, FOREIGN KEY (id_film) REFERENCES ', film_table_name,'(id), FOREIGN KEY (id_schedule) REFERENCES ', schedule_table_name,'(id), FOREIGN KEY (id_room) REFERENCES ', room_table_name,'(roomNumber))');
    PREPARE create_table_stmt FROM create_table_query;
    EXECUTE create_table_stmt;
    DEALLOCATE PREPARE create_table_stmt;

    /* --Creating table for the cinema's tickets (screening at a rate to a user) */
    
    SET tickets_table_name = CONCAT('TicketsCinema', cinema_id);
    SET create_table_query = CONCAT('CREATE TABLE ', tickets_table_name, ' (id INT AUTO_INCREMENT PRIMARY KEY, id_screening INT NOT NULL, id_user CHAR(36) NOT NULL, id_rate INT NOT NULL, FOREIGN KEY (id_screening) REFERENCES ', screenings_table_name,'(id), FOREIGN KEY (id_user) REFERENCES Users(id), FOREIGN KEY (id_rate) REFERENCES Rates(id))');
    PREPARE create_table_stmt FROM create_table_query;
    EXECUTE create_table_stmt;
    DEALLOCATE PREPARE create_table_stmt;

    /* --Creating an administrator for this cinema */



    SET user_name = CONCAT('Admin', cinema_id);
    SET admin_pass = CONCAT('ChangeThisPassw0rdASAP', user_name);
    SET create_user_query = CONCAT('CREATE USER ', user_name, "@'%' IDENTIFIED BY '", admin_pass, "'" );
    PREPARE create_user_stmt FROM create_user_query;
    EXECUTE create_user_stmt;
    DEALLOCATE PREPARE create_user_stmt;

    /* -- Granting admin rights */
    SET @grant_query = CONCAT('GRANT SELECT, INSERT, DELETE, UPDATE ON ', room_table_name, ' TO ', user_name, "@'%'");
    PREPARE grant_stmt FROM @grant_query;
    EXECUTE grant_stmt;
    DEALLOCATE PREPARE grant_stmt;

    SET @grant_query = CONCAT('GRANT SELECT, INSERT, DELETE, UPDATE ON ', screenings_table_name, ' TO ', user_name, "@'%'");
    PREPARE grant_stmt FROM @grant_query;
    EXECUTE grant_stmt;
    DEALLOCATE PREPARE grant_stmt;

    SET @grant_query = CONCAT('GRANT SELECT, INSERT, DELETE, UPDATE ON ', tickets_table_name, ' TO ', user_name, "@'%'");
    PREPARE grant_stmt FROM @grant_query;
    EXECUTE grant_stmt;
    DEALLOCATE PREPARE grant_stmt;




    /* -- granting restricted rigths on shared tables */
    SET @grant_query = CONCAT('GRANT SELECT, INSERT ON Films TO ', user_name, "@'%'");
    PREPARE grant_stmt FROM @grant_query;
    EXECUTE grant_stmt;
    DEALLOCATE PREPARE grant_stmt;

    SET @grant_query = CONCAT('GRANT SELECT, INSERT ON Rates TO ', user_name, "@'%'");
    PREPARE grant_stmt FROM @grant_query;
    EXECUTE grant_stmt;
    DEALLOCATE PREPARE grant_stmt;

    SET @grant_query = CONCAT('GRANT SELECT, INSERT ON Users TO ', user_name, "@'%'");
    PREPARE grant_stmt FROM @grant_query;
    EXECUTE grant_stmt;
    DEALLOCATE PREPARE grant_stmt;

    /*deallocate all variables*/
   /*  DEALLOCATE cinema_id ;
    DEALLOCATE room_table_name ;
    DEALLOCATE film_table_name ;
    DEALLOCATE schedule_table_name ;
    DEALLOCATE screenings_table_name ;
    DEALLOCATE tickets_table_name ;
    DEALLOCATE create_table_query ;
    DEALLOCATE create_user_query ;
    DEALLOCATE user_name ;
    DEALLOCATE admin_pass ; */

END//
DELIMITER ;


