# Intro to Relational Databases #

  This application implements a tournament, using a PostgreSQL database.
The database consists of two tables a list of players, and a match table that
stores a list of matches. The players are paired up based on the Swiss pairings
system. The tournament supports an odd number of players, and also supports ties.
A tie in this system counts as a win, also when a player is the only one in a
round they also get a free win.

## Getting Started ##

  All of the database commands are contained in the tournament.sql file, to load
the database into the system run the command `\i tournament.sql;` in the psql
command line from the terminal. Once the database is in the system run
`python tournament_test.py` to execute the program. In addition if tables and
views from the tournament.sql file need to be dropped quickly just enter
`\i drop.sql;` in the psql command line.

### Files Included ###
* tournament.py
* tournament_test.py
* tournament.sql
* drop.sql
* README.md

### Future Additions ###

* Prevent rematches between players.
* Support more than one tournament at a time.
