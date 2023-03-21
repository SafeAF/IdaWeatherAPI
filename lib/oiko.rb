require 'rest-client'
require 'json'
require 'date'

require 'uri'
require 'net/http'
 
API_KEY = 'c588435337e444c0996a94f746a2036b'











 









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


# options = {start: Time.now - 3600,
# end: Time.now, lat: 42.4632, lon: -114.4975}

# records = oiko_request(options, "temperature")

# p records



#### ChatGPT attempted to translate the oiko python script ####
# latitude = 42.4634
# longitude = -114.4975
# start_date = '2023-01-01'
# end_date = '2023-01-02'
#make_oiko_api_request(start_date, end_date, latitude, longitude)
def make_oiko_api_request(start_date, end_date, latitude, longitude)
    url = URI("https://api.oikolab.com/weather?param[]=temperature&param[]=dewpoint_temperature&param[]=soil_temperature_level_1&param[]=soil_temperature_level_2&param[]=soil_temperature_level_3&param[]=soil_temperature_level_4&param[]=surface_thermal_radiation&param[]=surface_solar_radiation&param[]=direct_normal_solar_radiation&param[]=surface_diffuse_solar_radiation&param[]=relative_humidity&param[]=surface_pressure&param[]=mean_sea_level_pressure&param[]=total_cloud_cover&param[]=total_precipitation&param[]=snowfall&param[]=snow_depth&param[]=snow_density&param[]=volumetric_soil_water_layer_1&param[]=volumetric_soil_water_layer_2&param[]=volumetric_soil_water_layer_3&param[]=volumetric_soil_water_layer_4&param[]=wind_speed&param[]=wind_direction&param[]=10m_wind_gust&param[]=100m_wind_speed&param[]=100m_wind_direction&start=#{start_date}&end=#{end_date}&lat=#{latitude}&lon=#{longitude}&api-key=c588435337e444c0996a94f746a2036b")
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(url)
    
    response = http.request(request)
    p response.read_body
    #weather_data = JSON.parse(response.read_body)["data"]
    
end
    