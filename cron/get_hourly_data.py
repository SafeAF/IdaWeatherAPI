import requests
import json
import pandas as pd
import datetime
#from datetime import datetime, timedelta


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

  

    #df.to_csv(str(loc) + "-" + str(latitude) + "-" + str(longitude) + "-" + str(start_date) + "-" + str(end_date) + "-full-params-idaho.csv")

    return(df)



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



from datetime import datetime, timedelta

end_date = datetime.now()
start_date= end_date - timedelta(hours=1)



for lat,lon, loc in coordinates:
    print("getting: " + str(lat) + " " + str(lon) + " " + str(loc))
    print(start_date, end_date)
    bar = make_request(lat, lon, start_date, end_date)
    print(bar)
    


# df = make_request(latitude, longitude, start_date, end_date)
# latest = df.tail(1)

# print(latest)

# connection = pymysql.connect(host='192.168.1.10',
#                              user='weather',
#                              password='d41d8cd98f00b204e9800998ecf8427e',
#                              db='weather')


# sql = "INSERT INTO employee (EmployeeID,
#  Ename, DeptID, Salary, Dname, Dlocation) 
#  VALUES (%s, %s, %s, %s, %s, %s)"

# cursor = connection.cursor()

# connection.commit()


# # Create a new record
# sql = "INSERT INTO employee (EmployeeID, Ename, DeptID, Salary, Dname, Dlocation) VALUES (%s, %s, %s, %s, %s, %s)"

# # Execute the query
# cursor.execute(sql, (1008,'Kabir',2,5000,'IT','New Delhi'))

# # the connection is not autocommited by default. So we must commit to save our changes.
# connection.commit()

    