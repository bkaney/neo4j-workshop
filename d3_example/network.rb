require 'rubygems'
require 'neography'
require 'sinatra'
require 'uri'

 
def follower_matrix
  neo = Neography::Rest.new
  cypher_query =  " START me = node:hackers_index(id='basho')"
  cypher_query << " MATCH me-[:works_on]->repos"
  cypher_query << " RETURN me.name, repos.name, repos.forks"
  cypher_query << " ORDER BY repos.name, repos.forks DESC"

  puts cypher_query
  neo.execute_query(cypher_query)["data"]
end  

def with_children(node)
  if node[node.keys.first].keys.first.is_a?(Integer)
    { "name" => node.keys.first,
      "size" => 1 + node[node.keys.first].keys.first}
  else
    { "name" => node.keys.first, 
      "children" => node[node.keys.first].collect { |c| 
        with_children(Hash[c[0], c[1]]) 
        } 
    }
  end
end

get '/hackers' do
  data = follower_matrix.inject({}) {|h,i| t = h; i.each {|n| t[n] ||= {}; t = t[n]}; h}
  with_children(data).to_json
end
