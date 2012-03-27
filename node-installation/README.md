Node Installation
===================

Prerequsite
-----------

You should have node and npm installed. You can do this several ways, such as:

 * installation instructions on http://nodejs.org
 * using homebrew `brew install node`
 * using NVM (node version manager) -- https://github.com/creationix/nvm


Download and Install Neo4j
--------------------------

It is typical to embed the database in a vendored directory in your project.  In this case the directory ./vendor/neo4j will be used.

1. Download the database, untar and move to a nice directory:

    $ curl http://dist.neo4j.org/neo4j-community-1.6.1-unix.tar.gz --O neo4j-community-1.6.1-unix.tar.gz
    $ tar -zxvf neo4j-community-1.6.1-unix.tar.gz
    $ mv neo4j-community-1.6.1 neo4j
    $ rm neo4j-community-1.6.1-unix.tar.gz


2. Start the server (ignore the ulimit complaint, OSX)

    $ ./neo4j/bin/neo4j start


3. Open the webadmin

    $ open http://localhost:7474


Install node-neo4j Library
--------------------------

You can do this manually with:

    $ npm install node-neo4j

Or use the packages.json with:

    $ npm install


Test Connection
---------------

There's a little connection test file here, you can run it like this:

    $ node neo4j_test.js


Let Others Access the Webadmin (optional)
-----------------------------------------

Uncomment line 17 in ./vendor/neo4j/conf/neo4j-server.properties

    org.neo4j.server.webserver.address=0.0.0.0                                                                                               
Save and then restart your server:

    $ ./neo4j/bin/neo4j restart

Figure our your IP address, give it to your friends (incl. port 7474)!
