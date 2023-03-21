# FarmersCodexAPI





## Credentials

### Oikolab

api-key: 'c588435337e444c0996a94f746a2036b'


## Weather Database


database: weather

weather:d41d8cd98f00b204e9800998ecf8427e

192.168.1.10


### SQL Script to create database weather

CREATE DATABASE weather;
CREATE USER 'weather'@'%' IDENTIFIED BY 'd41d8cd98f00b204e9800998ecf8427e';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, DROP, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON weather.* TO 'weather'@'%';



# Oikolab Data Explanation

temperature* 	Inst 	-80 	+80 	oC 	Drybulb temperature of air at 2m above the surface of land, sea or inland waters.

dewpoint_temperature* 	Inst 	-80 	+80 	oC 	The temperature to which the air at 2 metres above the surface of the Earth would have to be cooled for saturation to occur.

wetbulb_temperature* 	Inst 	-80 	+80 	oC 	The temperature read by a thermometer covered in water-soaked cloth over which air is passed.

humidex_index* 	Inst 	-80 	+80 	oC 	Humidex Index as defined by Canadian Meteorologists

soil_temperature_level_1* 	Inst 	-80 	+80 	oC 	Soil temperature at level 1 (0 - 7cm), in the middle of layer.

soil_temperature_level_2* 	Inst 	-80 	+80 	oC 	Soil temperature at level 2 (7 - 28cm), in the middle of layer.

soil_temperature_level_3* 	Inst 	-80 	+80 	oC 	Soil temperature at level 3 (28 - 100cm), in the middle of layer.

soil_temperature_level_4* 	Inst 	-80 	+80 	oC 	Soil temperature at level 4 (100 - 289cm), in the middle of layer.

sea_surface_temperature 	Inst 	-80 	+80 	oC 	The temperature of sea water near the surface. In ERA5, this parameter is a foundation SST, which means there are no diurnal variations. Before September 2007, SST from the HadISST2 dataset is used and from September 2007 onwards, the OSTIA dataset is used.

skin_temperature 	Inst 	-80 	+80 	oC 	The theoretical temperature that is required to satisfy the surface energy balance; it represents the temperature of the uppermost surface layer, which has no heat capacity. Skin temperature is calculated differently over land and sea.

wind_speed* 	Inst 	0 	+60 	m/s 	Wind speed at 10m above the surface.

wind_direction* 	Inst 	0 	360 	deg 	Wind direction at 10m above the surface.

10m_wind_gust 	Inst 	0 	+100 	m/s 	Instantaneous wind gust at 10m above surface.

10m_u_component_of_wind* 	Inst 	-100 	+100 	m/s 	U component of wind at 10m above the surface.

10m_v_component_of_wind* 	Inst 	-100 	+100 	m/s 	V component of wind at 10m above the surface.

100m_wind_speed 	Inst 	0 	+60 	m/s 	Wind speed at 100m above the surface.

100m_wind_direction 	Inst 	0 	360 	deg 	Wind direction at 100m above the surface.

100m_u_component_of_wind 	Inst 	-100 	+100 	m/s 	U component of wind at 100m above the surface.

100m_v_component_of_wind 	Inst 	-100 	+100 	m/s 	V component of wind at 100m above the surface.

surface_solar_radiation* 	Acc 	0 	1300 	W/m2 	Solar radiation (shortwave) that reaches a horizontal plane at the surface of the Earth. This parameter comprises both direct and diffuse solar radiation.

surface_thermal_radiation* 	Acc 	0 	500 	W/m2 	Thermal radiation (longwave) emitted by the atmosphere and clouds that reaches a horizontal plane at the surface of the Earth.

surface_direct_solar_radiation 	Acc 	0 	1300 	W/m2 	Direct solar radiation (shortwave) reaching the surface of the Earth, passing through a horizontal plane.

direct_normal_solar_radiation 	Acc 	0 	1300 	W/m2 	Solar radiation received per unit area normal to the direction of the sun.

surface_diffuse_solar_radiation 	Acc 	0 	1300 	W/m2 	Scattered solar radiation received per horizontal unit area on the surface.





relative_humidity* 	Inst 	0 	1 	- 	Relative humidity calculated from dewpoint temperature, drybulb temperature and pressure.

surface_pressure* 	Inst 	50000 	130000 	Pa 	The pressure (force per unit area) of the atmosphere at the surface of land, sea and inland water.

mean_sea_level_pressure 	Inst 	50000 	130000 	Pa 	The pressure (force per unit area) of the atmosphere at sea level.

total_cloud_cover 	Inst 	0 	1 	- 	Single level field calculated from the cloud occurring at different model levels through the atmosphere.

total_precipitation* 	Acc 	0 	50 	mm 	The accumulated liquid and frozen water, comprising rain and snow, that falls to the Earth's surface. It is the sum of large-scale precipitation and convective precipitation.

snowfall* 	Acc 	0 	50 	mm 	The accumulated snow that falls to the Earth's surface. It is the sum of large-scale snowfall and convective snowfall.

snow_depth 	Inst 	0 	300 	mm 	The amount of snow from the snow-covered area of a grid box in terms of water equivalent.

snow_density 	Inst 	100 	300 	kg/m^3 	The mass of snow per cubic metre in the snow layer.

volumetric_soil_water_layer_1* 	Inst 	0 	1 	- 	Soil moisture at level 1 (0 - 7cm).

volumetric_soil_water_layer_2* 	Inst 	0 	1 	- 	Soil moisture at level 2 (7 - 28cm).

volumetric_soil_water_layer_3* 	Inst 	0 	1 	- 	Soil moisture at level 3 (28 - 100cm).

volumetric_soil_water_layer_4* 	Inst 	0 	1 	- 	Soil moisture at level 4 (100 - 289cm).