var neo4j = require('neo4j');
var db = new neo4j.GraphDatabase('http://localhost:7474');

db.getVersion( function (err, result) {
  if (err) return console.log("Error Connecting!");
  console.log("Connected! Running Neo4j version: " + result);
});


var query = "START n=node(2663) RETURN n";

db.query(function (err, response) {
  if (err) console.log("Error " + err.message);
  console.log(response);
}, query);


var query = "START vermonster=node(2663), basho=node(3096)" \
  "MATCH p = shortestPath( vermonster-[*..15]->basho )" \
  "RETURN p"

db.query(function (err, response) {
  if (err) console.log("Error " + err.message);
  console.log(response);
}, query);
