### API For IdaWeather.com
### For rails dashboard to hit

require 'active_record'
require 'sinatra'
require 'rover-df'
require 'json'

require_relative '../db/idaho'
require_relative './lib/statistics'
require_relative './lib/historics'

# ActiveRecord::Base.establish_connection(
#     adapter: 'mysql2',
#     pool: 20,
#     host: '192.168.1.10',
#     username: 'weather',
#     password: 'd41d8cd98f00b204e9800998ecf8427e',
#     port: 3306,
#     database: 'weather',
#   )

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: '../../idaweather_prod.db'
)



start = Time.now
p "#{Time.now} - Loading dataframes"

# extract unique locations from db, make them keys in a hash of dataframes
#MyModel.pluck(:location).uniq
locations = Idaho.distinct.pluck(:location)
p "#{locations.count} locations found: #{locations.inspect}"





cache = {}

location = "Twin Falls"
#cache[location] = Rover::DataFrame.new(Idaho.where(location: location))



# locations.each {|location|
#     cache[location] = Rover::DataFrame.new(Idaho.where(location: location)
#                                         .where(year: 2022..))
#     p "#{Time.now} - #{cache[location].count} records for location #{location} loaded in #{(start - Time.now).abs} seconds"
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
     cache[location] = Rover::DataFrame.new(Idaho.where(location: location))
    JSON.generate(cache[location].count)
    #JSON.generate [location: location, records: @CACHE[location].count]
end

get '/see' do
    location = params[:location]
    JSON.generate(cache[location].count)
    
end

get '/historics' do
  location = params[:location]
  historics = calculate_historics(cache[location])
  JSON.generate historics
end



def prepare_coordinates(frames, graph)
  coords = []
  p graph.inspect



    if graph["category"] == "Range_across_years"
      valid_start = (1950..2022).include?(graph["start_year"])
      valid_end = (1950..2022).include?(graph["end_year"])
      if valid_start && valid_end
        coords = yearly_range(frames, graph["start_year"],
          graph["end_year"], graph["dependent_var"], graph["function"])

      else; coords = [{x: 1, y: 3}, {x: 2, y: 5}, {x: 3, y:7}]
      end

    elsif graph["category"] == "Compare_one_month_across_years"
      valid_start = (1950..2022).include?(graph["start_year"])
      valid_end = (1950..2022).include?(graph["end_year"])
      valid_month = (1..12).include?(graph["month"])
      if valid_start && valid_end && valid_month

        coords = compare_months_across_years(frames,
          graph["start_year"],
          graph["end_year"], 
          graph["month"], graph["dependent_var"], graph["function"])
 
      else; coords = [{x: 1, y: 3}, {x: 2, y: 5}, {x: 3, y:7}]
      end


    elsif graph["category"] == "Monthly_for_one_year"
      valid_year = (1950..2022).include?(graph["year"])
      if valid_year
        coords = year_by_month_function(frames, graph["year"], 
          graph["dependent_var"], graph["function"])
    #     coords = [{x: 1, y: 3}, {x: 2, y: 5}, {x: 3, y:7}]
        
    # if graph.category == "Monthly_average_for_one_year"
    #   coords = monthly_average(frames, graph.year, graph.dependent_var)
      else; coords = [{x: 1, y: 3}, {x: 2, y: 5}, {x: 3, y:7}]
      end
    
    elsif graph["category"] == "Hourly_for_one_month_in_a_single_year"
      valid_year = (1950..2022).include?(graph["year"])
      valid_month = (1..12).include?(graph["month"])

      if valid_year and valid_month
        coords = hourly_one_month_data(frames, graph["year"],
          graph["month"], graph["dependent_var"])
      
      else; coords = [{x: 1, y: 3}, {x: 2, y: 5}, {x: 3, y:7}]
      end

    else
      # bad category
      coords = [{x: 1, y: 3}, {x: 2, y: 5}, {x: 3, y:7}]
    end

  coords
end


post '/coordinates' do
  graph = JSON.parse(params["graph"])
  # make sure location is in the database
  allowed_functions = %w[min max mean]

  # # Check if the provided function is one of the allowed values
  # if allowed_functions.include?(graph['function'])
  #   # Call the method using send
  #   result = some_object.send(graph['function'])
  # else
  #   # Raise an error or handle the invalid input appropriately
  #   raise ArgumentError, "Invalid function: #{graph['function']}. Allowed values are #{allowed_functions.join(', ')}."
  # end
  if allowed_functions.include?(graph['function'])
    if Idaho.distinct.pluck(:location).include?(graph["location"])
      frames = Rover::DataFrame.new(Idaho.where(location: graph["location"]))
      coords = prepare_coordinates(frames, graph)
    else # return some default
      coords = [{x: 1, y: 3}, {x: 2, y: 5}, {x: 3, y:7}]
    end
  else
    coords = [{x: 1, y: 3}, {x: 2, y: 5}, {x: 3, y:7}]
  end
  
  JSON.generate coords
end

















