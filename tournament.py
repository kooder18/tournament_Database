#!/usr/bin/env python
#
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2
import bleach

def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament")


def deleteMatches():
    """Remove all the match records from the database."""
    DB = connect()
    c  = DB.cursor()
    c.execute("DELETE FROM match")
    DB.commit()
    DB.close()


def deletePlayers():
    """Remove all the player records from the database."""
    DB = connect()
    c = DB.cursor()
    c.execute("DELETE FROM playerList")
    DB.commit()
    DB.close()



def countPlayers():
    """Returns the number of players currently registered."""
    DB = connect()
    c  = DB.cursor()
    c.execute("SELECT count(*) FROM playerList")
    count = c.fetchone() #This returns a tuple
    temp = count[0] #The value is the first in the tuple
    DB.close() #Close the database
    count = int(temp) #Convert to int
    return count


def registerPlayer(name):
    """Adds a player to the tournament database.

    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)

    Args:
      name: the player's full name (need not be unique).
    """

    DB = connect()
    c  = DB.cursor()
    c.execute("INSERT INTO playerList (name) VALUES (%s)",
                (bleach.clean(name),)) #Sanitize the inputs

    DB.commit() #Commit the changes
    DB.close()
    #Notice that this function does not add in wins the wins
    #Column is therefore left blank.
def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or a player
    tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    #Needs to iterate through the playerList, for each player run a subquery
    #to check if that player has played any matches, if not, set matches and
    #wins to zero, if the player does appear in the match table then
    # run a count query on wins, and update the standings, then run a second
    #count query on wins or losses and add this to the total matches for that
    #player. Finally needs to rank the players based on wins

    DB = connect()
    c  = DB.cursor()
    c.execute("SELECT * FROM v_final;")
    standings = [(int(row[0]), str(row[1]), int(row[2]), int(row[3]))
                for row in c.fetchall()]
    DB.close()
    return standings


def reportMatch(winner, loser):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost
    """


    DB = connect()
    c = DB.cursor()
    c.execute("INSERT INTO match (winner, loser) VALUES (%s, %s)",
                (winner, loser))

    DB.commit()
    DB.close()


def swissPairings():
    """Returns a list of pairs of players for the next round of a match.

    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.

    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """

    DB = connect()
    c = DB.cursor()
    """totalPlayers = [(int(row[0]), int(row))] """
