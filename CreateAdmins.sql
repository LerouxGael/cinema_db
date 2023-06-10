USE cinema_db;

/*Creating 3 SuperAdmins with all privileges for example*/
INSERT INTO SuperAdmin (id, email, `password`)
VALUES (UUID(), 'superadmin1@example.com', SHA2('aGreatP4ssw0rd', 256));

SET @superadmin_id =LAST_INSERT_ID();
GRANT ALL PRIVILEGES ON cinema_db.* TO @superadmin_id@'%';


INSERT INTO SuperAdmin (id, email, `password`)
VALUES (UUID(), 'superadmin2@example.com', SHA2('anotherGreatP4ssw0rd', 256));


SET @superadmin_id =LAST_INSERT_ID();
GRANT ALL PRIVILEGES ON cinema_db.* TO @superadmin_id@'%';

INSERT INTO SuperAdmin (id, email, `password`)
VALUES (UUID(), 'superadmin3@example.com', SHA2('a3rdGreatP4ssw0rd', 256));

SET @superadmin_id =LAST_INSERT_ID();
GRANT ALL PRIVILEGES ON cinema_db.* TO @superadmin_id@'%';


/*FILLING COMMON TABLES*/
/*Populating Rooms table with an arbitrary amount of rooms, corresponding to the maximum number of room in the biggest cinema*/
DELIMITER //

CREATE PROCEDURE FillRoomsTable()
BEGIN
    DECLARE i INT DEFAULT 1;
    
    WHILE i <= 30 DO
        INSERT INTO Rooms (`room-number`) VALUES (i);
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL FillRoomsTable();

/*FILLING Rates Table*/
INSERT INTO Rates (title, price)
VALUES 
    ('Plein tarif', 9.20),
    ('Etudiant', 7.60),
    ('Moins de 14 ans', 5.90);

/*FILLING an example schedule for an arbitrary week*/
INSERT INTO ScheduledTimes (time)
VALUES
    ('2023-06-12 13:00:00'),
    ('2023-06-12 16:00:00'),
    ('2023-06-12 20:00:00'),
    ('2023-06-12 23:00:00'),
    ('2023-06-13 13:00:00'),
    ('2023-06-13 16:00:00'),
    ('2023-06-13 20:00:00'),
    ('2023-06-13 23:00:00'),
    ('2023-06-14 13:00:00'),
    ('2023-06-14 16:00:00'),
    ('2023-06-14 20:00:00'),
    ('2023-06-14 23:00:00'),
    ('2023-06-15 13:00:00'),
    ('2023-06-15 16:00:00'),
    ('2023-06-15 20:00:00'),
    ('2023-06-15 23:00:00'),
    ('2023-06-16 13:00:00'),
    ('2023-06-16 16:00:00'),
    ('2023-06-16 20:00:00'),
    ('2023-06-16 23:00:00'),
    ('2023-06-17 13:00:00'),
    ('2023-06-17 16:00:00'),
    ('2023-06-17 20:00:00'),
    ('2023-06-17 23:00:00'),
    ('2023-06-18 13:00:00'),
    ('2023-06-18 16:00:00'),
    ('2023-06-18 20:00:00'),
    ('2023-06-18 23:00:00');

/* Creating 5 cinemas with corresponding admins*/
DECLARE @cinema_id INT;
DECLARE @number-of-rooms INT;
DECLARE @i INT;
/*FIRST Cinema/Admin */

SET @cinema_id = 1;
INSERT INTO Admin (id, email, `password`, id_cinema)

VALUES (UUID(), 'admin1@example.com', SHA2('aTrueAdm1nPassw0rd', 256), @cinema_id);

/*Getting last created uuid*/
SET @admin_id = LAST_INSERT_ID();


SET @number-of-rooms = 6;
INSERT INTO Cinemas (id, numberOfRooms, name, id_admin)
VALUES (1, @number-of-rooms, 'Cinéma rathon', @admin_id);

/*All admins cad ADD a new film to the global list but not delete or update*/
GRANT INSERT ON films TO '@admin_id'@'%';
/*Granting Privileges only on corresponding cinema*/
GRANT SELECT, INSERT, UPDATE, DELETE ON FilmsInCinema TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON CinemaRates TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON CinemaSchedule TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON Screenings TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON Tickets TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;

/*Filling CinemaRooms junction Table*/
SET @i = 1;

WHILE @i <= @number-of-rooms DO
    INSERT INTO CinemaRooms (id_cinema, id_room)
    VALUES (@cinema_id, @i);
    
    SET @i = @i + 1;
END WHILE;

/*SECOND Cinema/Admin */

SET @cinema_id = 2;
INSERT INTO Admin (id, email, `password`, id_cinema)

VALUES (UUID(), 'admin2@example.com', SHA2('a2ndTrueAdm1nPassw0rd', 256), @cinema_id);

/*Getting last created uuid*/
SET @admin_id = LAST_INSERT_ID();

SET @number-of-rooms = 8;
INSERT INTO Cinemas (id, numberOfRooms, name, id_admin)
VALUES (1, @number-of-rooms, 'Cinéma rabout', @admin_id);

/*All admins cad ADD a new film to the global list but not delete or update*/
GRANT INSERT ON films TO '@admin_id'@'%';
/*Granting Privileges only on corresponding cinema*/
GRANT SELECT, INSERT, UPDATE, DELETE ON FilmsInCinema TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON CinemaRates TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON CinemaSchedule TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON Screenings TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON Tickets TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;

/*Filling CinemaRooms junction Table*/
SET @i = 1;

WHILE @i <= @number-of-rooms DO
    INSERT INTO CinemaRooms (id_cinema, id_room)
    VALUES (@cinema_id, @i);
    
    SET @i = @i + 1;
END WHILE;

/*THIRD Cinema/Admin */

SET @cinema_id = 3;
INSERT INTO Admin (id, email, `password`, id_cinema)

VALUES (UUID(), 'admin3@example.com', SHA2('a3rdTrueAdm1nPassw0rd', 256), @cinema_id);

/*Getting last created uuid*/
SET @admin_id = LAST_INSERT_ID();

SET @number-of-rooms = 4;
INSERT INTO Cinemas (id, numberOfRooms, name, id_admin)
VALUES (1, @number-of-rooms, 'Cinéma chinasous', @admin_id);

/*All admins cad ADD a new film to the global list but not delete or update*/
GRANT INSERT ON films TO '@admin_id'@'%';
/*Granting Privileges only on corresponding cinema*/
GRANT SELECT, INSERT, UPDATE, DELETE ON FilmsInCinema TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON CinemaRates TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON CinemaSchedule TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON Screenings TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON Tickets TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;

/*Filling CinemaRooms junction Table*/
SET @i = 1;

WHILE @i <= @number-of-rooms DO
    INSERT INTO CinemaRooms (id_cinema, id_room)
    VALUES (@cinema_id, @i);
    
    SET @i = @i + 1;
END WHILE;

/*FOURTH Cinema/Admin */

SET @cinema_id = 4;
INSERT INTO Admin (id, email, `password`, id_cinema)

VALUES (UUID(), 'admin4@example.com', SHA2('a4thTrueAdm1nPassw0rd', 256), @cinema_id);

/*Getting last created uuid*/
SET @admin_id = LAST_INSERT_ID();

SET @number-of-rooms = 11;
INSERT INTO Cinemas (id, numberOfRooms, name, id_admin)
VALUES (1, @number-of-rooms, 'Cinéma rionnette', @admin_id);

/*All admins cad ADD a new film to the global list but not delete or update*/
GRANT INSERT ON films TO '@admin_id'@'%';
/*Granting Privileges only on corresponding cinema*/
GRANT SELECT, INSERT, UPDATE, DELETE ON FilmsInCinema TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON CinemaRates TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON CinemaSchedule TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON Screenings TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON Tickets TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;

/*Filling CinemaRooms junction Table*/
SET @i = 1;

WHILE @i <= @number-of-rooms DO
    INSERT INTO CinemaRooms (id_cinema, id_room)
    VALUES (@cinema_id, @i);
    
    SET @i = @i + 1;
END WHILE;

/*FIFTH Cinema/Admin */

SET @cinema_id = 5;
INSERT INTO Admin (id, email, `password`, id_cinema)

VALUES (UUID(), 'admin5@example.com', SHA2('a5thTrueAdm1nPassw0rd', 256), @cinema_id);

/*Getting last created uuid*/
SET @admin_id = LAST_INSERT_ID();

SET @number-of-rooms = 9;
INSERT INTO Cinemas (id, numberOfRooms, name, id_admin)
VALUES (1, @number-of-rooms, 'Cinéma cabé', @admin_id);

/*All admins cad ADD a new film to the global list but not delete or update*/
GRANT INSERT ON films TO '@admin_id'@'%';
/*Granting Privileges only on corresponding cinema*/
GRANT SELECT, INSERT, UPDATE, DELETE ON FilmsInCinema TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON CinemaRates TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON CinemaSchedule TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON Screenings TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;
GRANT SELECT, INSERT, UPDATE, DELETE ON Tickets TO '@admin_id'@'%' WHERE id_cinema = @cinema_id;

/*Filling CinemaRooms junction Table*/
SET @i = 1;

WHILE @i <= @number-of-rooms DO
    INSERT INTO CinemaRooms (id_cinema, id_room)
    VALUES (@cinema_id, @i);
    
    SET @i = @i + 1;
END WHILE;