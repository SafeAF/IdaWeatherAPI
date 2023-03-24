require 'net/http'
require 'uri'
require 'json'




    # uri = URI.parse("http://localhost:4567/locations")
    # locs =  Net::HTTP.get_response(uri).body
    # locations = JSON.parse(locs)

    # p locations.last
    # firstlocation = locations.last
    # uri2 = URI.parse("http://localhost:4567/load?location=#{firstlocation}")
    # response = Net::HTTP.get_response(uri2)

    # puts response.body


uri = URI.parse("http://localhost:4567/historics?location=#{"Twin Falls"}")
see =  Net::HTTP.get_response(uri).body
saw = JSON.parse(see)
p saw


