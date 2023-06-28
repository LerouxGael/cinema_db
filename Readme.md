Has been tested using phpMyAdmin, with a 10.4.22-MariaDB server

original SQL is separated in two files

1- creation of database structure is stored in 'CreateDatabase.sql'
2- bogus data is inserted into the database in 'FillDatabase.sql'

modelisation.uxf file is the UML diagram, it can be viewed in VS Code using UMLet extension (by the UMLet Team)
you can also see the diagram in the UMLDiagram.png file

export.sql is the export from phpMyAdmin

The database is created with two admin accounts with all priviledges, more can be added if needed.

The database uses a few tables shared across all cinemas, and dedicated tables for each added cinema, created when a new cinema is added.

To add a new cinema to the database, use stored procedure new_cinema(cinema_name Varchar, number_of_rooms Int, list_of_seat_amounts_in_each_room Varchar)
the list of seat amounts is an string structured like an array (for exemple '[50,100,90,65]').
The stored procedure will create all tables associated with the newly added cinema as well as an Admin user with access rights to those tables.

The table TicketsCinema# stores all seats available in every room for every screening scheduled in a given Cinema ('#' beeing the cinema's id). A Boolean keeps track of the availability of the seat, making it possible to sell tickets for a specific seat if wanted.
