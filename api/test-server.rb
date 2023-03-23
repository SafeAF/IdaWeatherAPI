require 'net/http'
require 'uri'
require 'json'




def load_location
    uri = URI.parse("http://localhost:4567/locations")
    locs =  Net::HTTP.get_response(uri).body
    locations = JSON.parse(locs)

    p locations.first
    firstlocation = locations.first
    uri2 = URI.parse("http://localhost:4567/load?location=#{firstlocation}")
    response = Net::HTTP.get_response(uri2)

    puts response.body
end

uri = URI.parse("http://localhost:4567/see")
locs =  Net::HTTP.get_response(uri).body
locations = JSON.parse(locs)
p locations