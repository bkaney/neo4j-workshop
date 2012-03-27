Bare Installation
=================

1. Download the database, untar and move to a nice directory:

    $ curl http://10.10.100.11:8000/~jfredett/neo4j-community-1.6.1-unix.tar.gz --O neo4j-community-1.6.1-unix.tar.gz
    $ tar -zxvf neo4j-community-1.6.1-unix.tar.gz
    $ mv neo4j-community-1.6.1 neo4j


2. Start the server (ignore the ulimit complaint)
    $ ./neo4j/bin/neo4j start


3. Open the webadmin
    $ open localhost:7474

# Let others access the webadmin

Uncomment line 17 in ./neo4j/conf/neo4j-server.properties

    org.neo4j.server.webserver.address=0.0.0.0                                                                                               
Save and then restart your server:

    $ ./neo4j/bin/neo4j restart

Figure our your IP address, give it to your friends!
