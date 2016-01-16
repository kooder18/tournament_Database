# Intro to Relational Databases #

  This application implements a tournament, using a PostgreSQL database.
The database consists of two tables a list of players, and a match table that
stores a list of matches. The players are paired up based on the Swiss pairings
system.

## Getting Started ##

  All of the database commands are contained in the tournament.sql file, to load
the database into the system run the command `\i tournament.sql` in the psql
command line from the terminal. Once the database is in the system run
`python tournament_test.py` to execute the program.

## Future Additions ##

* Prevent rematches between players.
* Allow for a tie.
* Support an odd number of players.
* Support more than one tournament at a time.
