/* Create database and use it */

CREATE DATABASE IF NOT EXISTS cinema_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE cinema_db;

/* Creation of the Admin Table, relation 1 to 1 with the Cinemas Table */

CREATE TABLE Admin(
    id char(36) NOT NULL PRIMARY KEY,
    email varchar(50) NOT NULL UNIQUE,
    /* Password might be a reserved keyword so we pass it between ` ` */
    `password` varchar(255) NOT NULL,
    /*This will be a foreign Key*/
    id_cinema int(11) NOT NULL,
    /*Foreign key will be added after the creation of Cinemas Table*/
);

CREATE TABLE Cinemas(
    id int(11) NOT NULL PRIMARY KEY,
    numberOfRooms int(11) NOT NULL,
    name varchar(50) NOT NULL,
    /* Foreign key linked to Admin Table */
    id_admin char(36) NOT NULL UNIQUE,
    FOREIGN KEY (id_admin) REFERENCES Admin(id),
);

/* Adding foreign key to Admin Table*/
ALTER TABLE Admin
ADD CONSTRAINT FK_Admin_Cinema FOREIGN KEY (id_cinema) REFERENCES Cinemas(id);

/*Creating Films Table*/
CREATE TABLE Films(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    `length` INT(11) NOT NULL,
)