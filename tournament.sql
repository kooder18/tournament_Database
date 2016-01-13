-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

/*
--Uncomment this to create the database if needed
DROP DATABASE tournament;
CREATE DATABASE tournament;
\c tournament;
*/


--This is the first table that holds the basic player
--data. It has two columns, one for the player name
--the other is the unique id
CREATE TABLE playerList ( id SERIAL primary key,
                          name TEXT);



--This is the table that stores the matches, it holds data for
--The match id and both player ids it references the playerList
--Table so that only registered players may be in the match.
CREATE TABLE match ( matchID SERIAL primary key,
                     winner INT references playerList (id),
                     loser INT references playerList (id));



--This is a view called v_win takes the number of wins a player has
CREATE VIEW v_win as SELECT playerList.name, count(playerList.name) as
                       win_total FROM playerList, match WHERE playerList.id=match.winner
                       GROUP BY playerList.name ORDER BY win_total desc;

--This is a view called v_match it adds the number of wins and losses to get the total matches played.
CREATE VIEW v_match as SELECT playerList.name, count(playerList.name) as
                        v_match FROM playerList, match WHERE playerList.id=match.winner OR
                        playerList.id=match.loser GROUP BY playerList.name ORDER BY v_match desc;


/* Simple test data to test out SQL queries
This first block adds 16 different players to the
playerList table.
*/

INSERT INTO playerList (name) VALUES('Stewie Griffin');
INSERT INTO playerList (name) VALUES('Sherry Chen');
INSERT INTO playerList (name) VALUES('Snowman');
INSERT INTO playerList (name) VALUES('Iceman');
INSERT INTO playerList (name) VALUES('Fireman');
INSERT INTO playerList (name) VALUES('Grassman');
INSERT INTO playerList (name) VALUES('Stuntman');
INSERT INTO playerList (name) VALUES('Cameraman');
INSERT INTO playerList (name) VALUES('Rainman');
INSERT INTO playerList (name) VALUES('Pacman');
INSERT INTO playerList (name) VALUES('Burningman');
INSERT INTO playerList (name) VALUES('Hungryman');
INSERT INTO playerList (name) VALUES('Superman');
INSERT INTO playerList (name) VALUES('Xman');
INSERT INTO playerList (name) VALUES('Nakedman');
INSERT INTO playerList (name) VALUES('Grumpyman');


/*
More test data, this data updates the matches table
*/

INSERT INTO match (winner, loser) VALUES (1, 2);
INSERT INTO match (winner, loser) VALUES (3, 4);
INSERT INTO match (winner, loser) VALUES (5, 6);
INSERT INTO match (winner, loser) VALUES (7, 8);
INSERT INTO match (winner, loser) VALUES (9, 10);
INSERT INTO match (winner, loser) VALUES (11, 12);
INSERT INTO match (winner, loser) VALUES (13, 14);
INSERT INTO match (winner, loser) VALUES (15, 16);
INSERT INTO match (winner, loser) VALUES (2, 4);
INSERT INTO match (winner, loser) VALUES (6, 8);
INSERT INTO match (winner, loser) VALUES (10, 12);
INSERT INTO match (winner, loser) VALUES (14, 16);
INSERT INTO match (winner, loser) VALUES (1, 3);
INSERT INTO match (winner, loser) VALUES (5, 7);
INSERT INTO match (winner, loser) VALUES (9, 11);
INSERT INTO match (winner, loser) VALUES (13, 15);
