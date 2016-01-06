-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


--This is the first table that holds the basic player
--data. It has three columns, one for the player name
--the other is the unique id, and the final is the number of wins
CREATE TABLE playerList ( name TEXT,
                          id SERIAL primary key, wins INTEGER );



--This is the table that stores the matches, it holds data for
--The match id and both player ids it references the playerList
--Table so that only registered players may be in the match.
CREATE TABLE match ( matchID SERIAL primary key,
                     player1ID SERIAL references playerList,
                     player2ID SERIAL references playerList,
                     winner SERIAL references playerList );
