require 'active_record'
require_relative 'idaho'

# ActiveRecord::Base.establish_connection(
#   adapter: 'mysql2',
#   pool: 5,
#   host: '192.168.1.10',
#   username: 'weather',
#   password: 'd41d8cd98f00b204e9800998ecf8427e',
#   port: 3306,
#   database: 'weather',
# )



ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: '../../idaweather_prod.db'
)
