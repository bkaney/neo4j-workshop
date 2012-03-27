require 'neography'

@neo = Neography::Rest.new(ENV["NEO4J_URL"] || "http://localhost:7474")

query = "START n=node(2663) RETURN n"
puts @neo.execute_query(query).inspect

query = <<-QUERY
  START vermonster=node(2663), basho=node(3096)
  MATCH p = shortestPath( vermonster-[*..15]->basho )
  RETURN p
QUERY
puts @neo.execute_query(query).inspect
