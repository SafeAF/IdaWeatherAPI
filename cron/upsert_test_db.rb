require 'active_record'
require_relative '../db/idaho'
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
  
  coordinates = [
    [42.4634, -114.4975, "Twin Falls"],
    [42.5992, -114.7591, "Buhl"], 
    [42.4679, -114.1523, 'Murtaugh'],
    [42.6351, -113.7199, "Burley"],
    [42.8751, -112.8793, "Pocatello"],
    [42.4436, -112.2156, "Idaho Falls"],
    [42.6556, -116.8516, "Caldwell"],
    [42.9180, -115.9554, "Mountain Home"],
    [43.6798, -114.3558, "Ketchum"],
    [42.9764, -114.6886, "Gooding"],
    [42.2759, -113.8956, "Oakley"],
    [43.8798, -116.5310, "Emmett"],
    [45.9759, -116.1236, "Grangeville"],
    [47.7037, -116.7576, "Cour d'Alene"],
    [46.6949, -116.9428, "Moscow"],
    [42.0409, -114.8722, "Mountains West of Jackpot"],
    [42.1364, -114.2932, "Pike Mountain"],
    [43.3436, -114.2055, "Gannet"],
    [42.7788, -113.5280, "Minidoka"],
    [44.0428, -116.9370, "Payette"],
    [45.1691, -113.8279, "Salmon"]
]


params = [
    "temperature",
    "dewpoint_temperature",
    "soil_temperature_level_1",
    "soil_temperature_level_2",
    "soil_temperature_level_3",
    'soil_temperature_level_4',
    "surface_thermal_radiation",
    "surface_solar_radiation",
    "direct_normal_solar_radiation",
    "surface_diffuse_solar_radiation",
    "relative_humidity",
    "surface_pressure",
    "mean_sea_level_pressure",
    "total_cloud_cover",
    "total_precipitation",
    "snowfall",
    "snow_depth",
    "snow_density",
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

## USAGE ##
# options = {start: Time.now - 3600,
# end: Time.now, lat: 42.4632, lon: -114.4975}

# records = oiko_request(options, "temperature")

# p records

# request to api not returning all fields listed in parameters!
# just use one parameter then at a time, has to be a string

# Try this

# Set the parameters for the POST request

    # params = {
    #     year: 2022,
    #     locations: ['New York', 'San Francisco'].to_json
    # }
def make_oiko_request(options = {}, params)
    parameters = params
    foo = {"params" =>
      {
        param: parameters,
        start: options[:start],
        end: options[:end],
        lat: options[:lat],
        lon: options[:lon],
        'api-key' => API_KEY
      }
    }
      p foo
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
  


coord = coordinates.first

#coordinates.each { |coord| 
options = {start: Time.now - 3600,
end: Time.now, lat: coord[0], lon: coord[1], location: coord[2]}


# build hash of current conditions

# grab the last element of the return AoA, which is the desired parameter
foo = oiko_request(options, params)
p foo
    









