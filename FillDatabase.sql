
USE cinema_db;

/*

FILLING Films TABLE WITH MOVIES

*/

INSERT INTO Films (title, `length`) VALUES
('The Shawshank Redemption', 142),
('The Godfather', 175),
('The Dark Knight', 152),
('Pulp Fiction', 154),
('Fight Club', 139),
('Goodfellas', 146),
('The Matrix', 136),
('Forrest Gump', 142),
('Inception', 148),
('The Lord of the Rings: The Fellowship of the Ring', 178),
('The Silence of the Lambs', 118),
('Schindler List', 195),
('The Avengers', 143),
('Interstellar', 169),
('Gladiator', 155),
('The Departed', 151),
('The Lion King', 88),
('Titanic', 194),
('Star Wars: Episode IV - A New Hope', 121),
('The Green Mile', 189),
('Saving Private Ryan', 169),
('The Shawshank Redemption', 142),
('The Godfather: Part II', 202),
('The Dark Knight Rises', 165),
('The Empire Strikes Back', 124),
('The Prestige', 130),
('The Wolf of Wall Street', 180),
('Jurassic Park', 127),
('The Great Gatsby', 143),
('The Revenant', 156),
('Inglourious Basterds', 153),
('Django Unchained', 165),
('The Departed', 151),
('The Social Network', 120),
('The Big Lebowski', 117),
('Braveheart', 178),
('The Grand Budapest Hotel', 100),
('Oldboy', 120),
('Reservoir Dogs', 99),
('La La Land', 128),
('12 Angry Men', 96),
('No Country for Old Men', 122),
('Blade Runner', 117),
('Amélie', 122),
('The Truman Show', 103),
('The Sixth Sense', 107),
('The Princess Bride', 98),
('Eternal Sunshine of the Spotless Mind', 108),
('The Shining', 146),
('Raiders of the Lost Ark', 115);

/*

CREATING A CINEMA

*/
/*Associated tables and Admin are created within the Stored procedure*/

CALL new_cinema('Cinema Rathon', 8, '[50,60,80,100,40,30,80,80]');
CALL new_cinema('Cinema Rabout', 12, '[40,30,80,80,50,60,80,100,40,30,80,80]');

/* Inserting 15 movies in this cinema's 
for reference : INSERT INTO FilmsInCinema1(id_film) SELECT (id) FROM Films LIMIT 15;*/
DELIMITER //
CREATE PROCEDURE insert_movies(IN cine_id INT)
BEGIN
  DECLARE table_name VARCHAR(255);
  DECLARE film_query VARCHAR(1000);

  SET table_name =CONCAT('filmsincinema',cine_id);
  SET film_query = CONCAT('INSERT INTO ',table_name ,'(id_film) SELECT (id) FROM Films LIMIT 15');
  PREPARE film_stmt FROM film_query;
  EXECUTE film_stmt;
  DEALLOCATE PREPARE film_stmt;
END //
DELIMITER ;

CALL insert_movies(1);
CALL insert_movies(2);


/*Inserting available schedule
INSERT INTO ScheduleCinema1 (scheduledTime)
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
    ('2023-06-18 23:00:00');*/

DELIMITER //
CREATE PROCEDURE insert_schedule(IN cine_id INT)
BEGIN
  DECLARE table_name VARCHAR(255);
  DECLARE schedule_query VARCHAR(1000);

  SET table_name =CONCAT('schedulecinema',cine_id);
  SET schedule_query = CONCAT("INSERT INTO ",table_name," (scheduledTime)
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
    ('2023-06-18 23:00:00');");
    PREPARE schedule_stmt FROM schedule_query;
    EXECUTE schedule_stmt;
    DEALLOCATE PREPARE schedule_stmt;
END//
DELIMITER ;

CALL insert_schedule(1);
CALL insert_schedule(2);



/*Filling junction table, each room now has it's own schedule
INSERT INTO ScheduleRoomCinema1 (id_room, nb_seats, id_schedule)
SELECT r.roomNumber, r.seats, s.id
FROM RoomsCinema1 AS r
CROSS JOIN ScheduleCinema1 AS s;*/

DELIMITER //
CREATE PROCEDURE insert_schedule_room(IN cine_id INT)
BEGIN
  DECLARE table_name VARCHAR(255);
  DECLARE table2_name VARCHAR(255);
  DECLARE table3_name VARCHAR(255);
  DECLARE schedule_room_query VARCHAR(1000);

  SET table_name =CONCAT('scheduleroomcinema',cine_id);
  SET table2_name =CONCAT('roomscinema',cine_id);
  SET table3_name =CONCAT('schedulecinema',cine_id);
  SET schedule_room_query = CONCAT('INSERT INTO ',table_name, ' (id_room, nb_seats, id_schedule)
SELECT r.roomNumber, r.seats, s.id
FROM ',table2_name,' AS r
CROSS JOIN ',table3_name,' AS s;');
  PREPARE schedule_room_stmt FROM schedule_room_query;
  EXECUTE schedule_room_stmt;
  DEALLOCATE PREPARE schedule_room_stmt;
END //
DELIMITER ;

CALL insert_schedule_room(1);
CALL insert_schedule_room(2);

/*Filling Screenings table, 
INSERT INTO ScreeningsCinema1 (id_room_schedule, nb_seats, id_film)
SELECT id, nb_seats, (SELECT id_film FROM FilmsInCinema1 ORDER BY RAND() LIMIT 1)
FROM ScheduleRoomCinema1;*/
DELIMITER //
CREATE PROCEDURE fillscreenings(IN cine_id INT)
BEGIN
  DECLARE table_name VARCHAR(255);
  DECLARE table2_name VARCHAR(255);
  DECLARE table3_name VARCHAR(255);
  DECLARE fill_screenings_query VARCHAR(1000);

  SET table_name =CONCAT('screeningscinema',cine_id);
  SET table2_name =CONCAT('filmsincinema',cine_id);
  SET table3_name =CONCAT('scheduleroomcinema',cine_id);
  SET fill_screenings_query = CONCAT('INSERT INTO ',table_name, ' (id_room_schedule, nb_seats, id_film)
SELECT id, nb_seats, (SELECT id_film FROM ',table2_name,' ORDER BY RAND() LIMIT 1)
FROM ',table3_name);
  PREPARE fill_screening_stmt FROM fill_screenings_query;
  EXECUTE fill_screening_stmt;
  DEALLOCATE PREPARE fill_screening_stmt;
END //
DELIMITER ;

CALL fillscreenings(1);
CALL fillscreenings(2);



/*Creating tickets*/


/* PROCEDURE to create tickets for cinema1, haven't been able to make it dynamic yet */

DELIMITER //

CREATE PROCEDURE create_tickets()
BEGIN
  DECLARE currentId INT;
  DECLARE currentSeats INT;
  
  -- Curseur pour parcourir les enregistrements de screeningscinema1
  DECLARE cur CURSOR FOR SELECT id, nb_seats FROM screeningscinema1;
  
  -- Variables pour stocker les valeurs actuelles du curseur
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET @done = 1;
  
  -- Ouvrir le curseur
  OPEN cur;
  
  -- Initialiser les variables
  SET @done = 0;
  
  -- Boucle pour parcourir les enregistrements de screeningscinema1
  read_loop: LOOP
    -- Lire les valeurs actuelles du curseur
    FETCH cur INTO currentId, currentSeats;
    
    -- Sortir de la boucle si tous les enregistrements ont été parcourus
    IF @done = 1 THEN
      LEAVE read_loop;
    END IF;
    
    -- Insérer les enregistrements dans ticketscinema1
    SET @counter = 1;
    WHILE @counter <= currentSeats DO
      INSERT INTO ticketscinema1 (id_screening) VALUES (currentId);
      SET @counter = @counter + 1;
    END WHILE;
  END LOOP;
  
  -- Fermer le curseur
  CLOSE cur;
  

END //

DELIMITER 

/* PROCEDURE to create tickets for cinema2 */

DELIMITER //

CREATE PROCEDURE create_tickets2()
BEGIN
  DECLARE currentId INT;
  DECLARE currentSeats INT;
  
  -- Curseur pour parcourir les enregistrements de screeningscinema2
  DECLARE cur CURSOR FOR SELECT id, nb_seats FROM screeningscinema2;
  
  -- Variables pour stocker les valeurs actuelles du curseur
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET @done = 1;
  
  -- Ouvrir le curseur
  OPEN cur;
  
  -- Initialiser les variables
  SET @done = 0;
  
  -- Boucle pour parcourir les enregistrements de screeningscinema2
  read_loop: LOOP
    -- Lire les valeurs actuelles du curseur
    FETCH cur INTO currentId, currentSeats;
    
    -- Sortir de la boucle si tous les enregistrements ont été parcourus
    IF @done = 1 THEN
      LEAVE read_loop;
    END IF;
    
    -- Insérer les enregistrements dans ticketscinema2
    SET @counter = 1;
    WHILE @counter <= currentSeats DO
      INSERT INTO ticketscinema2 (id_screening) VALUES (currentId);
      SET @counter = @counter + 1;
    END WHILE;
  END LOOP;
  
  -- Fermer le curseur
  CLOSE cur;
  

END //

DELIMITER ;

/*Calling procedures*/
CALL create_tickets();
CALL create_tickets2();







