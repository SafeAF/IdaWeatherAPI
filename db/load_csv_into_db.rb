require 'active_record'
require 'csv'
require_relative 'idaho'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  pool: 5,
  host: '192.168.1.10',
  username: 'weather',
  password: 'd41d8cd98f00b204e9800998ecf8427e',
  port: 3306,
  database: 'weather',
)

def load_data_into_sql(file)
    counter = 0
    table = CSV.foreach(file) do |row|
        next if row[0].nil? # header row
        lat, lon = row[1].split(',')
        lat.gsub!(/[^0-9\.]/, '')
        lon.gsub!(/[^0-9\.]/, '')
        
        location = file.split('-')[0]
        location = location.gsub(/^\.\//, '') 

        Idaho.create(
            'location' => location,
            'year' => Time.parse(row[0]).year,
            'month' => Time.parse(row[0]).month,
            'day' => Time.parse(row[0]).day,
            'hour' => Time.parse(row[0]).hour,
            'time_index' => row[0],
            'lat' => lat,
            'lon' => lon,
            'temperature' => row[5],
            'dewpoint_temperature' => row[6],
            'soil_temperature_level_1' => row[7],
            'soil_temperature_level_2' => row[8],
            'soil_temperature_level_3' => row[9],
            'soil_temperature_level_4' => row[10],
            'surface_thermal_radiation' => row[11],
            'surface_solar_radiation' => row[12],
            'direct_normal_solar_radiation' => row[13],
            'surface_diffuse_solar_radiation' => row[14],
            'relative_humidity' => row[15],
            'surface_pressure' => row[16],
            'mean_sea_level_pressure' => row[17],
            'total_cloud_cover' => row[18],
            'total_precipitation' => row[19],
            'snowfall' => row[20],
            'snow_depth' => row[21],
            'snow_density' => row[22],
            'volumetric_soil_water_layer_1' => row[23],
            'volumetric_soil_water_layer_2' => row[24],
            'volumetric_soil_water_layer_3' => row[25],
            'volumetric_soil_water_layer_4' => row[26],
            'wind_speed' => row[27],
            'wind_direction' => row[28],
            '10m_wind_gust' => row[29],
            '100m_wind_speed' => row[30],
            '100m_wind_direction' => row[31],
      ) { counter+=1 }

    end
    return counter
  end
  

#directory_path = ARGV[0] || "./"
directory_path = "./"

# Get a list of all CSV files in the directory
csv_files = Dir.glob(File.join(directory_path, '*.csv'))
csv_files.each do |datafile|
    
  inserts = load_data_into_sql(datafile)
  p "#{inserts} records inserted."
end


