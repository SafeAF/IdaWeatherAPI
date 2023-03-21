require 'active_record'
require_relative '../db/historical'
require 'rest-client'
require 'json'
require 'date'

 
API_KEY = 'c588435337e444c0996a94f746a2036b'

ActiveRecord::Base.establish_connection(
    adapter: 'mysql2',
    host: '192.168.1.10',
    username: 'weather',
    password: 'd41d8cd98f00b204e9800998ecf8427e',
    port: 3306,
    database: 'weather',
    pool: 20,
  ) 

## USAGE ##
# options = {start: Time.now - 3600,
# end: Time.now, lat: 42.4632, lon: -114.4975}

# records = oiko_request(options, "temperature")

# p records

# request to api not returning all fields listed in parameters!
# just use one parameter then at a time, has to be a string
def make_oiko_request(options = {}, param)

    foo = {"params" =>
      {
        param: param,
        start: options[:start],
        end: options[:end],
        lat: options[:lat],
        lon: options[:lon],
        'api-key' => API_KEY
      }
    }
  
     RestClient.get 'https://api.oikolab.com/weather', foo
  
  end
  
  def parse_oiko_request_into_data_frames(response)
    first_pass = JSON.parse(response)
    second_pass = JSON.parse(first_pass["data"])
    # pair index (time) with data row, create frame
    data_frames = second_pass["data"].each_with_index do |frame, index|
      # add time index to the front of dataframe, its located elsewhere in the json response
      
      frame.unshift Time.at(second_pass["index"][index]).to_datetime
    end
      return data_frames
  end
  
  # takes a hash as an argument
  #options = {start: '2010-01-01', end: '2010-01-02', lat: 42.4632, lon: -114.4975}
  def oiko_request(options, param)
      return parse_oiko_request_into_data_frames(make_oiko_request(options, param))
  end
  
  

params = [
    "temperature",
    "dewpoint_temperature",
    "soil_temperature_level_1",
    "soil_temperature_level_2",
    "soil_temperature_level_3",
    'soil_temperature_level_4',
    "surface_thermal_radiation",
    "surface_solar_radiation",
   # "direct_normal_solar_radiation",
    "surface_diffuse_solar_radiation",
    "relative_humidity",
    "surface_pressure",
    "mean_sea_level_pressure",
    "total_cloud_cover",
    "total_precipitation",
    "snowfall",
    "snow_depth",
    #"snow_density",
    "volumetric_soil_water_layer_1",
    "volumetric_soil_water_layer_2",
    "volumetric_soil_water_layer_3",
    "volumetric_soil_water_layer_4",
    "wind_speed",
    "wind_direction",
    "10m_wind_gust",
    "100m_wind_speed",
    "100m_wind_direction"
]




current = {}
options = {start: Time.now - 3600,
end: Time.now, lat: 42.4632, lon: -114.4975}


# params.each {|param|
#     p param
#     current[param] = oiko_request(options, param)[0][-1]
# }

#p current

p oiko_request(options, "temperature")[0][0]









def create_observation_record
    h = Historical.create(

    )
end




  
# options = {start: Time.now,
#  end: Time.now, lat: 42.4632, lon: -114.4975}

# param = "temperature"

# records = make_oiko_request(options, param)
# p records
# records.each do |row| 
#     create_observation_record(row)
# end



# def create_observation_record(row)

#   o = Historical.create(
#      'time_index' => row[0],
#      'latlong' => row[1],
#      'temperature' => row[5],
#      'dewpoint_temperature' => row[6],
#      'mean_sea_level_pressure' => row[7],
#      'wind_speed' => row[8],
#      'relative_humidity' => row[9],
#      'surface_thermal_radiation' => row[10],
#      'surface_solar_radiation' => row[11],
#      'total_cloud_cover' => row[12]
#     )

#       # data feed is 7 hours ahead of actual timezone
#     o.time_index = o.time_index - 7.hours

#     o.year = o.time_index.year 
#     o.month = o.time_index.month
#     o.day = o.time_index.day
#     o.hour = o.time_index.hour 

#     o.save!
  
# end

