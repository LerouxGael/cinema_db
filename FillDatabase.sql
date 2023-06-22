
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

/* Inserting 15 movies in this cinema's table*/
INSERT INTO FilmsInCinema1(id_film) SELECT (id) FROM Films LIMIT 15;

/*Inserting available schedule*/

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
    ('2023-06-18 23:00:00');

/*Filling junction table, each room now has it's own schedule*/
INSERT INTO ScheduleRoomCinema1 (id_room, id_schedule)
SELECT r.roomNumber, s.id
FROM RoomsCinema1 AS r
CROSS JOIN ScheduleCinema1 AS s;

/*Filling Screenings table, */

INSERT INTO ScreeningsCinema1 (id_room_schedule, id_film)
SELECT id, (SELECT id_film FROM FilmsInCinema1 ORDER BY RAND() LIMIT 1)
FROM ScheduleRoomCinema1;

/*Creating tickets*/

INSERT INTO TicketsCinema1 (id_screening)







