-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


DROP DATABASE tournament;
CREATE DATABASE tournament;
\c tournament;



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



--This is a view called v_win that counts the number of total wins each player has
CREATE VIEW v_win as SELECT playerList.id, count(playerList.id) as
                       win_total FROM playerList, match WHERE playerList.id=match.winner
                       GROUP BY playerList.id;
                       -- ORDER BY win_total desc;

--This is a view called v_match it adds the number of wins and losses to get the total matches played.
CREATE VIEW v_match as SELECT playerList.id, count(playerList.id) as
                        v_match FROM playerList, match WHERE playerList.id=match.winner OR
                        playerList.id=match.loser GROUP BY playerList.id;
                        --ORDER BY v_match desc;

/*This view makes a left join of the player table with the  v_win view,
the reason it does this is to include all of the players including those
who did not win any matches.
*/
CREATE VIEW v_allwin as SELECT playerList.*, v_win.win_total FROM playerList LEFT
                              OUTER JOIN v_win ON playerList.id = v_win.id;


/*
This view performs a left join on the v_match table with the playerList table
the reason this is done is to include any players who did not play any matches.
*/
CREATE VIEW v_allmatch as SELECT playerList.*, v_match.v_match FROM playerList
                                LEFT OUTER JOIN v_match ON
                                playerList.id = v_match.id;

/*
This view takes the allwin view, and runs the coalesce function on it,
the reason for this is to replace all null values of players who have not
won any matches with zero So we will not need to check for this in the python
code.
*/
CREATE VIEW v_winf as SELECT *, COALESCE(win_total, 0) AS wins FROM
                              v_allwin;


/*
This view takes the allmatch view, and runs coalese on it to replace all null
values with zero.
*/
CREATE VIEW v_matchf as SELECT *, COALESCE(v_match,0) AS match
                               FROM v_allmatch;

--This is the final view with all the pieces in the table
CREATE VIEW v_final as SELECT v_winf.id, v_winf.name, v_winf.wins, v_matchf.match
                              FROM v_winf LEFT OUTER JOIN v_matchf ON
                              v_winf.id = v_matchf.id ORDER BY wins desc;

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
INSERT INTO playerList (name) VALUES('Sherry Chen');




/*
More test data, this data updates the matches table
*/

INSERT INTO match (winner, loser) VALUES (1, 3);
INSERT INTO match (winner, loser) VALUES (2, 3);
INSERT INTO match (winner, loser) VALUES (2, 3);
INSERT INTO match (winner, loser) VALUES (2, 3);
INSERT INTO match (winner, loser) VALUES (3, 4);
INSERT INTO match (winner, loser) VALUES (5, 6);
INSERT INTO match (winner, loser) VALUES (7, 8);
INSERT INTO match (winner, loser) VALUES (9, 10);
INSERT INTO match (winner, loser) VALUES (11, 12);
INSERT INTO match (winner, loser) VALUES (13, 14);
INSERT INTO match (winner, loser) VALUES (15, 16);
INSERT INTO match (winner, loser) VALUES (5, 4);
INSERT INTO match (winner, loser) VALUES (6, 8);
INSERT INTO match (winner, loser) VALUES (10, 12);
INSERT INTO match (winner, loser) VALUES (14, 16);
INSERT INTO match (winner, loser) VALUES (1, 3);
INSERT INTO match (winner, loser) VALUES (5, 7);
INSERT INTO match (winner, loser) VALUES (9, 11);
INSERT INTO match (winner, loser) VALUES (13, 15);
