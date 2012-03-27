Exercises
=========

Open up your console (http://localhost:7474) and run through these exercises.


Create a Node
---------------

  REST:

    POST /db/data/node { "name": "Stiltman" }


Update Node Properties
----------------------

  REST:

    PUT /db/data/node/1/properties/alias "stilty"
  
Get a Node by ID
----------------

  REST:

    GET /db/data/node/1

  Cypher:
  
    START n=node(1)
    RETURN n



Create a Second Node
-------------------

  REST:
  
    POST /db/data/node { "name": "Stiltman Goes to Lunch" }


Create an Edge
--------------

  REST:

    POST /db/data/node/1/relationships { "to" : "/db/data/node/2", "type" : "appeared_in", "data" : { "featured": true }}


Get Edges
---------

  REST:

    GET /db/data/node/1/relationships/all
    GET /db/data/node/2/relationships/all

    GET /db/data/node/1/relationships/in
    GET /db/data/node/1/relationships/out
    
    GET /db/data/node/2/relationships/in
    GET /db/data/node/2/relationships/out


Create Node Index
-----------------

  REST:

    POST /db/data/index/node { "name" : "characters" }

  REST:

    POST /db/data/index/node/characters { "uri" : "/db/data/node/1", "key" : "name", "value" : "Stiltman" }
    POST /db/data/index/node/characters { "uri" : "/db/data/node/1", "key" : "alias", "value" : "stilty" }
    

List Indexes
------------

  REST:

    GET /db/data/index/node


Find Node by Exact Match (Lookup)
---------------------------------

  REST:

    GET /db/data/index/node/characters/name/Stiltman

  Cypher:

    START n=node:characters(name='Stiltman')
    RETURN n


Find Node by Query
------------------

  REST:

    GET /db/data/index/node/characters?query=alias:stilty%20AND%20name:Stiltman

  Cypher:

    START n=node:characters('name:Stiltman AND alias:stilty')
    RETURN n


Create Fulltext Index
---------------------

  REST:

    POST /db/data/index/node { "name" : "fulltext_characters", "config" : { "type" : "fulltext" }}
  
  REST:

    POST /db/data/index/node/fulltext_characters { "uri" : "/db/data/node/1", "key" : "name", "value" : "Stiltman" }
    POST /db/data/index/node/fulltext_characters { "uri" : "/db/data/node/1", "key" : "alias", "value" : "stilty" }
  

Query Fulltext
--------------

  REST:
    
    GET /db/data/index/node/characters?query=name:*man    

  Cypher:

    START n=node:fulltext_characters('name:*man')
    RETURN n


Let us Load Some Real Data
==========================

Stop your neo4j server.

    $ ./neo4j/bin/neo4j stop

Download the data using the CURL command!

    $ cd ./neo4j/data
    $ curl http://192.168.0.11/~jfredett/graph.tar.gz --O graph.tar.gz
    $ tar -zxvf graph.tar.gz
    $ rm graph.tar.gz

Start neo4j server

    $ cd ../../
    $ ./neo4j/bin/neo4j start

The rest of the exercises are mainly using Cypher.

Follow an Edge, return Nodes
----------------------------

    START vermonster=node(2663)
    MATCH vermonster-->s
    RETURN s


Follow an Edge, return Edges
----------------------------

    START vermonster=node(2663)
    MATCH vermonster-[r]->()
    RETURN r


Follow a Specific Edge, return Nodes
------------------------------------

    START vermonster=node(2663)
    MATCH vermonster-[:hacks_in]->language
    RETURN language

Follow a Specific Edge, return Edges
------------------------------------
    
    START vermonster=node(2663)
    MATCH vermonster-[r:works_on]->()
    RETURN r


Follow Multiple
---------------

    START vermonster=node(2663)
    MATCH vermonster-[:works_on]->repo-[:written_in]->language
    RETURN language

    START vermonster=node(2663)
    MATCH vermonster-[:works_on]->()-[:written_in]->language
    RETURN language

Variation with Inward
---------------------
    
    START vermonster=node(2663)
    MATCH vermonster-[:works_on]->()-[:written_in]->language<-[:hacks_in]-hacker
    RETURN hacker


Use a WHERE clause
------------------

    START joe=node:hackers_index(id='jfredett')
    MATCH joe-[:works_on]->()-[:written_in]->language<-[:hacks_in]-hacker
    WHERE language.name = 'Ruby' OR language.name = 'JavaScript'
    RETURN language, hacker


Using a Built-In Algorithm
--------------------------

    START joe=node:hackers_index(id='jfredett'), jonathan=node:hackers_index(id='hynkle')
    MATCH p = shortestPath( joe-[*..10]-jonathan )
    RETURN p


Visualization
-------------

    Check out the d3_example project.


CHALLENGE!
==========

For the next approx 1 hour, group into teams of 4 and hack hack hack.  Here are some ideas:

  * Best expansion --
    Think twitter, quora, stackoverflow -- use github username and see if there are accounts, extend graph!

  * Best visual interactivity --
    d3.js is a nice place to start, make it more interactive!

  * Graph metrics --
    Conceive of your own way to measure graph, use centrality -- most important language, location, hacker, etc!


Thanks
======

We were inspired by: https://github.com/danchoi/boston-rubyists to get our initial collection of hackers.
We are really impressed by d3.js and https://github.com/maxdemarzi/d3_js_network
