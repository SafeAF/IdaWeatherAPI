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