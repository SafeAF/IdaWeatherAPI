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
  
  coordinates = [
    [42.4634, -114.4975, "Joslin Field"],
    [42.5992, -114.759, "Buhl"], 
    [42.4679, -114.1523, 'Murtaugh'],
    [42.6351, -113.7199, "Burley"],
    [42.8751, -112.8793, "Pocatello"],
    [42.4436, -112.2156, "Idaho Falls"],
    [42.6556, -116.8516, "Caldwell"],
    [42.9180, -115.9554, "Mountain Home"],
    [43.679833, -114.355867, "Ketchum"],
    [42.976403, -114.688651, "Gooding"],
    [42.275969, -113.895653, "Oakley"],
    [43.879858, -116.531095, "Emmett"],
    [45.975976, -116.123625, "Grangeville"],
    [47.703796, -116.757602, "Cour d'Alene"],
    [46.694995, -116.942834, "Moscow"],
    [42.040929, -114.872226, "Mountains West of Jackpot"],
    [42.136474, -114.293275, "Pike Mountain"],
    [43.343642, -114.205501, "Gannet"],
    [42.778824, -113.528056, "Minidoka"],
    [44.042849, -116.937079, "Payette"],
    [45.169153, -113.827914, "Salmon"]
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
  

  def create_observation_record(o)
    o["year"] = o["time_index"].year
    o["month"] = o["time_index"].month
    o["day"] = o["time_index"].day
    o["hour"] = o["time_index"].hour
    # create db record from hash of observation created in the coordinates.each loop
    h = Historical.create(o)
    h.save!
end


coordinates.each { |coord| 
    options = {start: Time.now - 3600,
    end: Time.now, lat: coord[0], lon: coord[1], location: coord[2]}
    
    current = {}
    # lazily get the time index, easier than doing it inside the following loop
    current["time_index"] = oiko_request(options, "temperature")[0][0]
    current["lat"] = options[:lat] 
    current["lon"] = options[:lon]
    current["location"] = options[:location]
    
    # build hash of current conditions
    params.each {|param|    
        current[param] = oiko_request(options, param)[0][-1]
    }
    
    p current
    # store in database
    create_observation_record(current)
}










