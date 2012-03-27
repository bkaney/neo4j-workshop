require 'neography'

@neo = Neography::Rest.new(ENV["NEO4J_URL"] || "http://localhost:7474")

query = "START n=node(2663) RETURN n"
puts @neo.execute_query(query).inspect

query = <<-QUERY
  START joe=node:hackers_index(id='jfredett')
  MATCH joe-[:works_on]->()-[:written_in]->language<-[:hacks_in]-hacker
  WHERE language.name = 'Ruby' OR language.name = 'JavaScript'
  RETURN language, hacker
QUERY

puts @neo.execute_query(query).inspect
