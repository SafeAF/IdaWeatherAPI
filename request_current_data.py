import requests
import json
import pandas as pd
import pymysql

def make_request(latitude, longitude, start_date, end_date):
    r = requests.get('https://api.oikolab.com/weather',
                 params={'param': ['temperature',
                 'dewpoint_temperature',
                 'soil_temperature_level_1',
                 'soil_temperature_level_2',
                 'soil_temperature_level_3',
                 'soil_temperature_level_4',
                 'surface_thermal_radiation',
                 'surface_solar_radiation',
                 'direct_normal_solar_radiation',
                 'surface_diffuse_solar_radiation',
                 'relative_humidity',
                 'surface_pressure',
                 'mean_sea_level_pressure',
                 'total_cloud_cover',
                 'total_precipitation',
                 'snowfall',
                 'snow_depth',
                 'snow_density',
                 'volumetric_soil_water_layer_1',
                 'volumetric_soil_water_layer_2',
                 'volumetric_soil_water_layer_3',
                 'volumetric_soil_water_layer_4',
                 'wind_speed',
                 'wind_direction',
                 '10m_wind_gust',
                 '100m_wind_speed',
                 '100m_wind_direction',
                 
                 ],
                         'start': start_date,
                         'end': end_date,
                         'lat': latitude,
                         'lon': longitude,
                         'api-key': 'c588435337e444c0996a94f746a2036b'}
                 )




    weather_data = json.loads(r.json()['data'])
    df = pd.DataFrame(index=pd.to_datetime(weather_data['index'],
                                       unit='s'),
                  data=weather_data['data'],
                  columns=weather_data['columns'])

  
    return df
   # df.to_csv(str(latitude) + "-" + str(longitude) + "-" + start_date + "-" + end_date + "-full-params-idaho.csv")





latitude = 42.4634
longitude = -114.4975
start_date = '2023-01-01'
end_date = '2023-01-02'


df = make_request(latitude, longitude, start_date, end_date)
latest = df.tail(1)

print(latest)

connection = pymysql.connect(host='192.168.1.10',
                             user='weather',
                             password='d41d8cd98f00b204e9800998ecf8427e',
                             db='weather')


sql = "INSERT INTO employee (EmployeeID,
 Ename, DeptID, Salary, Dname, Dlocation) 
 VALUES (%s, %s, %s, %s, %s, %s)"

cursor = connection.cursor()

connection.commit()


# # Create a new record
# sql = "INSERT INTO employee (EmployeeID, Ename, DeptID, Salary, Dname, Dlocation) VALUES (%s, %s, %s, %s, %s, %s)"

# # Execute the query
# cursor.execute(sql, (1008,'Kabir',2,5000,'IT','New Delhi'))

# # the connection is not autocommited by default. So we must commit to save our changes.
# connection.commit()


#coordinates = [
    #(42.4634, -114.4975), # joslin field
    # (42.5992, -114.759), # buhl
    # (42.4679, -114.1523), #murtaugh
    # (42.6351, -113.7199), #burley
    # (42.8751, -112.8793), #pocatello
    # (42.4436, -112.2156), #idaho falls
    # (42.6556, -116.8516), #boise/caldwell
    # (42.9180, -115.9554), #mountain home
    # (43.679833, -114.355867), #ketchum
    # (42.976403, -114.688651), #gooding
    # (42.275969, -113.895653), #oakley
    # (43.879858, -116.531095), #emmett
    # (45.975976, -116.123625), #grangeville
    # (47.703796, -116.757602), #cour d'alene
    # (46.694995, -116.942834), # moscow 
    # (42.040929, -114.872226), #mountains west of  jackpot
    # (42.136474, -114.293275), #mountains east of jackpot (pike mountain area)
    # (43.343642, -114.205501), # gannet



   # (42.778824, -113.528056), #minidoka
   # (44.042849, -116.937079), #payette
  # (45.169153, -113.827914), #salmon
 

#]

# for lat,lon in coordinates:
#     print("getting: " + str(lat) + " " + str(lon))
#     make_request(lat, lon, start_date, end_date)
    