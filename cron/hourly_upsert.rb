require 'active_record'
require_relative '../lib/oiko'
require_relative '../db/historical'

ActiveRecord::Base.establish_connection(
    adapter: 'mysql2',
    host: '192.168.1.10',
    username: 'weather',
    password: 'd41d8cd98f00b204e9800998ecf8427e',
    port: 3306,
    database: 'weather',
    pool: 20,
  ) 

  options = {start: Time.now - 3600,
  end: Time.now, lat: 42.4632, lon: -114.4975}
  
  records = make_oiko_request(options, "temperature")
  
  p records



  
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

