require 'csv'
require 'standard_deviation'

# Load the CSV file containing the temperature, pressure, and wind data
data = CSV.read('weather_data.csv', headers: true)

# Extract the temperature, pressure, and wind data into separate arrays
temperatures = data['temperature'].map(&:to_f)
pressures = data['pressure'].map(&:to_f)
winds = data['wind'].map(&:to_f)

# Normalize the data by subtracting the mean and dividing by the standard deviation
temperature_mean = temperatures.mean
temperature_std_dev = temperatures.standard_deviation
temperatures = temperatures.map { |t| (t - temperature_mean) / temperature_std_dev }

pressure_mean = pressures.mean
pressure_std_dev = pressures.standard_deviation
pressures = pressures.map { |p| (p - pressure_mean) / pressure_std_dev }

wind_mean = winds.mean
wind_std_dev = winds.standard_deviation
winds = winds.map { |w| (w - wind_mean) / wind_std_dev }

# Combine the normalized data into a single input array
input = temperatures.zip(pressures, winds)

# Print the preprocessed data for verification
puts "Normalized Temperatures: #{temperatures}"
puts "Normalized Pressures: #{pressures}"
puts "Normalized Winds: #{winds}"
puts "Input Array: #{input}"








require 'csv'
require 'standard_deviation'
require 'ruby-fann'


# Read the data from the CSV file
data = CSV.read('data.csv', headers: true, header_converters: :symbol)

# Preprocess the temperature data
temperatures = data[:temperature].map(&:to_f)
temp_mean = temperatures.mean
temp_std_dev = temperatures.standard_deviation
preprocessed_temperatures = temperatures.map { |temp| (temp - temp_mean) / temp_std_dev }

# Preprocess the pressure data
pressures = data[:pressure].map(&:to_f)
pressure_mean = pressures.mean
pressure_std_dev = pressures.standard_deviation
preprocessed_pressures = pressures.map { |pressure| (pressure - pressure_mean) / pressure_std_dev }

# Preprocess the wind data
winds = data[:wind].map(&:to_f)
wind_mean = winds.mean
wind_std_dev = winds.standard_deviation
preprocessed_winds = winds.map { |wind| (wind - wind_mean) / wind_std_dev }

# Prepare the inputs and outputs for the ANN
inputs = preprocessed_temperatures.zip(preprocessed_pressures, preprocessed_winds)
outputs = data[:future_temperature].map(&:to_f)

# Train the ANN on the preprocessed data
fann = RubyFann::Standard.new(num_inputs: 3, hidden_neurons: [4, 2], num_outputs: 1)
train_data = RubyFann::TrainData.new(inputs: inputs, desired_outputs: outputs)
fann.train_on_data(train_data, 5000, 100, 0.01)

# Use the trained ANN to predict the temperature at a certain date
new_data = [[25.0, 1013.0, 5.0]] # Example data for a certain date
preprocessed_new_data = new_data.map { |temp, pressure, wind| [(temp - temp_mean) / temp_std_dev, (pressure - pressure_mean) / pressure_std_dev, (wind - wind_mean
