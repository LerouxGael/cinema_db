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

INSERT INTO Cinemas(id,  numberOfRooms, `name`)
VALUES( 1, 7, 'Cinéma Rathon' );

/*Associated tables are created with the TRIGGER created before*/


INSER INTO FilmsInCinema1(id_film)
VALUES 
    (1),
    (3),
    (6),
    (9),
    (10),
    (13),
    (16),
    (50),
    (40),
    (30),
    (20);


INSERT INTO Cinema1Rooms(roomNumber, seats)
VALUES 
    (1,50),
    (2,65),
    (3,100),
    (4,92),
    (5,75),
    (6,100),
    (7,66),



INSERT INTO Cinema1Schedule (scheduledTime)
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




/* CREATING ADMIN for Cinema 1*/

CREATE USER 'admin-cinema1'@'%' IDENTIFIED BY 'aTrueAdm1nPassw0rd';

/* Cinema admins can not delete or update Films Table because it is shared with other cinemas*/
GRANT SELECT, INSERT ON cinema_db.Films TO 'admin-cinema1'@'%';

GRANT ALL PRIVILEGES ON cinema_db.FilmsInCinema1 TO 'admin-cinema1'@'%';
GRANT ALL PRIVILEGES ON cinema_db.Cinema1Schedule TO 'admin-cinema1'@'%';
GRANT ALL PRIVILEGES ON cinema_db.Cinema1Screenings TO 'admin-cinema1'@'%';
GRANT ALL PRIVILEGES ON cinema_db.Cinema1Tickets TO 'admin-cinema1'@'%';

FLUSH PRIVILEGES;




/*

CREATING A SECOND CINEMA

*/

INSERT INTO Cinemas(id,  numberOfRooms, `name`)
VALUES( 1, 11, 'Cinéma Rabout' );


/* CREATING ADMIN for Cinema 2*/

CREATE USER 'admin-cinema2'@'%' IDENTIFIED BY 'anoth3rTrueAdm1nPassw0rd';

/* Cinema admins can not delete or update Films Table because it is shared with other cinemas*/
GRANT SELECT, INSERT ON cinema_db.Films TO 'admin-cinema2'@'%';

GRANT ALL PRIVILEGES ON cinema_db.FilmsInCinema2 TO 'admin-cinema2'@'%';
GRANT ALL PRIVILEGES ON cinema_db.Cinema2Schedule TO 'admin-cinema2'@'%';
GRANT ALL PRIVILEGES ON cinema_db.Cinema2Screenings TO 'admin-cinema2'@'%';
GRANT ALL PRIVILEGES ON cinema_db.Cinema2Tickets TO 'admin-cinema2'@'%';

FLUSH PRIVILEGES;





