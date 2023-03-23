### API For Storing Weather Data (In Memory)
### For rails dashboard to hit

require 'active_record'
require 'sinatra'
require 'rover-df'
require 'json'

require_relative '../db/idaho'
# require_relative './lib/statistics'
# require_relative './lib/historics'

ActiveRecord::Base.establish_connection(
    adapter: 'mysql2',
    pool: 20,
    host: '192.168.1.10',
    username: 'weather',
    password: 'd41d8cd98f00b204e9800998ecf8427e',
    port: 3306,
    database: 'weather',
  )

start = Time.now
p "#{Time.now} - Loading dataframes"

# extract unique locations from db, make them keys in a hash of dataframes
#MyModel.pluck(:location).uniq
locations = Idaho.distinct.pluck(:location)
p "#{locations.count} locations found: #{locations.inspect}"

location = locations.first

cache = {}
cache[location] = Rover::DataFrame.new(Idaho.where(location: location))

# locations.each {|location|
#     #frames = Rover::DataFrame.new(Idaho.where(location: location))
#     #CACHE[location] = frames
#     CACHE[location] = Rover::DataFrame.new(Idaho.where(location: location))
#     p "#{Time.now} - #{CACHE[location].count} records for location #{location} loaded in #{(start - Time.now).abs} seconds"
# }



# ######### Index #############
get '/' do
  "Farmers Almanac API v1.0"
end

get '/locations' do
    JSON.generate locations
end

get '/load' do
    
     location = params[:location]



    location
    #JSON.generate [location: location, records: @CACHE[location].count]
end

get '/see' do
    JSON.generate(cache["Buhl"].count)
    
end

# get '/historics/:location' do
#   historics = calculate_historics(CACHE)
#   JSON.generate historics
# end

### Example script to hit this endpoint
# require 'httparty'

# # Set the endpoint URL
# url = 'http://localhost:4567/my_endpoint'

# # Set the parameters for the POST request
# params = {
#   year: 2022,
#   location: 'New York'
# }

# # Send the POST request using HTTParty
# response = HTTParty.post(url, body: params)

# # Print the response status code and body
# puts "Response code: #{response.code}"
# puts "Response body: #{response.body}"

# post '/data' do
#     # Parse the request body as JSON
#     request.body.rewind
#     data = JSON.parse(request.body.read)
  
#     # Extract the year and location fields from the JSON data
#     year = data['year']
#     location = data['location']
  
#     # Do something with the year and location data (e.g. store it in a database)
  
#     # Return a JSON response with a success message
#     { message: "Data received: year=#{year}, location=#{location}" }.to_json
#   end

#   post '/my_endpoint' do
#     year = params['year']
#     locations = JSON.parse(params['locations'])
  
#     # Do something with the year and locations parameters
#     # ...
  
#     # Return a response
#     status 200
#     body "Year: #{year}, Locations: #{locations}"
#   end
  


# def prepare_coordinates(frames, graph)
#   coords = []
#   p graph.inspect


#   if graph.range  
#     if graph.category == "Range_across_years"
#       coords = yearly_range(frames, graph.start_year,
#          graph.end_year, graph.dependent_var, graph.function)

#     elsif graph.category == "Compare_one_month_across_years"
#       coords = compare_months_across_years(frames,
#          graph.start_year, graph.end_year, 
#          graph.month, graph.dependent_var, graph.function)
#     end

#   else
#     if graph.category == "Monthly_for_one_year"
#       coords = year_by_month_function(frames, graph.year, 
#         graph.dependent_var, graph.function)
#     #     coords = [{x: 1, y: 3}, {x: 2, y: 5}, {x: 3, y:7}]
        
#     # if graph.category == "Monthly_average_for_one_year"
#     #   coords = monthly_average(frames, graph.year, graph.dependent_var)
    
    
#     elsif graph.category == "Hourly_for_one_month_in_a_single_year"
#       coords = hourly_one_month_data(frames, graph.year,
#         graph.month, graph.dependent_var)
      
#     else
#       # bad category
#     end


#   end
#   coords
# end

# get '/graph/:id' do
#   graph = Graph.find(params[:id])
#   coords = prepare_coordinates(frames,graph)
#   #p coords
#   JSON.generate coords
# end



# class SendTestbed < TestBed
#     def call(event)
#       handler_name = "handle_#{event.name}"
#       __send__(handler_name, event) if respond_to?(handler_name)
#     end

#     def handle_foo(event)
#       event_log << event
#     end

#     def handle_bar(event)
#       event_log << event
#     end

#     def handle_baz(event)
#       event_log << event
#     end
# end
