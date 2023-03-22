require 'active_record'


ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  pool: 5,
  host: '192.168.1.10',
  username: 'weather',
  password: 'd41d8cd98f00b204e9800998ecf8427e',
  port: 3306,
  database: 'weather',
)

ActiveRecord::Schema.define do


create_table "idahos", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.datetime "time_index"
    t.string "location"
    t.float "lat"
    t.float "lon"
    t.integer "year"
    t.integer "month"
    t.integer "day"
    t.integer "hour"
    t.float "temperature"
    t.float "dewpoint_temperature"
    t.float "soil_temperature_level_1"
    t.float "soil_temperature_level_2"
    t.float "soil_temperature_level_3"
    t.float 'soil_temperature_level_4'
    t.float "surface_thermal_radiation"
    t.float "surface_solar_radiation"
    t.float "direct_normal_solar_radiation"
    t.float "surface_diffuse_solar_radiation"
    t.float "relative_humidity"
    t.float "surface_pressure"
    t.float "mean_sea_level_pressure"
    t.float "total_cloud_cover"
    t.float "total_precipitation"
    t.float "snowfall"
    t.float "snow_depth"
    t.float "snow_density"
    t.float "volumetric_soil_water_layer_1"
    t.float "volumetric_soil_water_layer_2"
    t.float "volumetric_soil_water_layer_3"
    t.float "volumetric_soil_water_layer_4"
    t.float "wind_speed"
    t.float "wind_direction"
    t.float "10m_wind_gust"
    t.float "100m_wind_speed"
    t.float "100m_wind_direction"
  end

end