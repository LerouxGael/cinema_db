/* Create database and use it */

CREATE DATABASE IF NOT EXISTS cinema_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE cinema_db;

/* Creation of the Admin Table, relation 1 to 1 with the Cinemas Table */

CREATE TABLE Admin(
    id CHAR(36) NOT NULL PRIMARY KEY,
    email VARCHAR(50) NOT NULL UNIQUE,
    /* Password might be a reserved keyword so we pass it between ` ` */
    `password` VARCHAR(255) NOT NULL,
    /*This will be a foreign Key*/
    id_cinema INT(11) NOT NULL,
    /*Foreign key will be added after the creation of Cinemas Table*/
);

CREATE TABLE Cinemas(
    id INT(11) NOT NULL PRIMARY KEY,
    numberOfRooms INT(11) NOT NULL,
    name VARCHAR(50) NOT NULL,
    /* Foreign key linked to Admin Table */
    id_admin char(36) NOT NULL UNIQUE,
    FOREIGN KEY (id_admin) REFERENCES Admin(id),
);

/* Adding foreign key to Admin Table*/
ALTER TABLE Admin
ADD CONSTRAINT FK_Admin_Cinema FOREIGN KEY (id_cinema) REFERENCES Cinemas(id);

/*CREATING SuperAdmin Table*/
CREATE TABLE SuperAdmin(
    id CHAR(36) NOT NULL PRIMARY KEY,
    email VARCHAR(50) NOT NULL UNIQUE,
    /* Password might be a reserved keyword so we pass it between ` ` */
    `password` VARCHAR(255) NOT NULL,
);

/* Relation between SuperAdmins Table and Cinema Table is a Many to Many relationship
so we create a junction Table*/

CREATE TABLE SuperAdminCinema(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_superadmin CHAR(36) NOT NULL,
    id_cinema INT(11) NOT NULL,
    FOREIGN KEY (id_superadmin) REFERENCES SuperAdmin(id),
    FOREIGN KEY (id_cinema) REFERENCES Cinemas(id),
);

/*Users can be anonymous, therefor personnal attributes are optionnal, 
but anonymous users get an id to keep track of sales*/
CREATE TABLE Users(
    id CHAR(36) PRIMARY KEY,
    email VARCHAR(50) UNIQUE,
    `password` VARCHAR(255),
);

/*Creating Films Table containing all films available in all cinemas*/
CREATE TABLE Films(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    `length` INT(11) NOT NULL,
);

/* Creating juction Table between Cinema and Films for a Many to Many relationShip*/
CREATE TABLE FilmInCinema(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_film INT,
    id_cinema INT,
    FOREIGN KEY (id_film) REFERENCES Films(id),
    FOREIGN KEY (id_cinema) REFERENCES Cinemas(id),
);

/*Creating Rates Table, storing the different rates practiced in all cinemas*/
CREATE TABLE Rates(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    /*Using Decimal with (4,2) to be able to calculate a price up to 9999.99, 
    might need to be changed if used with a currency using high numbers*/
    price DECIMAL(4,2) NOT NULL,
);

/*Joining each cinema to the practiced rates in a Many to Many relationship*/
CREATE TABLE CinemaRates(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cinema INT NOT NULL,
    id_rate INT NOT NULL,
    FOREIGN KEY (id_cinema) REFERENCES Cinemas(id),
    FOREIGN KEY (id_rate) REFERENCES Rates(id),
);

/*Creating Rooms Table*/
CREATE Table Rooms(
    id INT AUTO_INCREMENT PRIMARY KEY,
    /*number is a reserved Keyword*/
    `room-number` INT(11) NOT NULL UNIQUE,
);

/*Joining Cinema to room numbers in a Many to Many Relationship*/
CREATE TABLE CinemaRooms(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cinema INT NOT NULL,
    id_room INT NOT NULL,
    FOREIGN KEY (id_cinema) REFERENCES Cinemas(id),
    FOREIGN KEY (id_room) REFERENCES Rooms(id),
);

/*Creating Table storing available Scheduled times*/
CREATE TABLE ScheduledTimes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    time DATE NOT NULL UNIQUE,
);

/*Joining Cinema and ScheduledTimes Tables*/
CREATE TABLE CinemaSchedule(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cinema INT NOT NULL,
    id_scheduledTime INT NOT NULL,
    FOREIGN KEY (id_cinema) REFERENCES Cinemas(id),
    FOREIGN KEY (id_scheduledTime) REFERENCES ScheduledTimes(id),
);

/*Creating Screenings Table*/
CREATE TABLE Screenings(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cinema INT NOT NULL,
    id_cinemaSchedule INT NOT NULL,
    id_cinemaFilm INT NOT NULL,
    id_cinemaRoom INT NOT NULL,
    FOREIGN KEY (id_cinema) REFERENCES Cinemas(id),
    FOREIGN KEY (id_cinemaSchedule) REFERENCES CinemaSchedule(id),
    FOREIGN KEY (id_cinemaFilm) REFERENCES FilmInCinema(id),
    FOREIGN KEY (id_cinemaRoom) REFERENCES CinemaRooms(id),
);

/*Creating Tickets Table*/
CREATE TABLE Tickets(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_screening INT NOT NULL,
    id_user CHAR(36) NOT NULL,
    id_cinemaRate INT NOT NULL,
    FOREIGN KEY (id_screening) REFERENCES Screenings(id),
    FOREIGN KEY (id_user) REFERENCES Users(id),
    FOREIGN KEY (id_cinemaRate) REFERENCES CinemaRates(id),
);