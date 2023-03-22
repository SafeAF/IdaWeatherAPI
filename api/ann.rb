require 'csv'
require 'fann'
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

# Extract the temperature data for the output array, offset by one day
output = temperatures[1..-1]

# Initialize the FANN neural network with three input nodes, one output node, and one hidden layer with four nodes
network = FANN::Standard.new(num_inputs: 3, hidden_neurons: [4], num_outputs: 1)

# Train the network on the input and output data
network.train_on_data(FANN::TrainData.new(input, output))

# Generate a prediction for the next day's temperature
prediction = network.run([temperatures.last, pressures.last, winds.last])

# Denormalize the prediction by multiplying by the standard deviation and adding the mean
prediction = (prediction.first * temperature_std_dev) + temperature_mean

puts "Prediction for tomorrow's temperature: #{prediction.round(2)}"



#################
require 'ruby-fann'
require 'date'

# Load the historical temperature, pressure, and wind data from a CSV file
data = File.readlines('historical_data.csv').map { |line| line.split(',').map(&:to_f) }

# Separate the inputs (temperature, pressure, and wind) from the output (temperature)
inputs = data.map { |row| row[0..-2] }
output = data.map { |row| row[-1] }

# Normalize the input and output data to values between 0 and 1
input_min = inputs.flatten.min
input_max = inputs.flatten.max
output_min = output.min
output_max = output.max

normalized_inputs = inputs.map { |row| row.map { |value| (value - input_min) / (input_max - input_min) } }
normalized_output = output.map { |value| (value - output_min) / (output_max - output_min) }

# Train a feedforward artificial neural network on the normalized data
num_inputs = inputs.first.length
num_outputs = 1
num_hidden = (num_inputs + num_outputs) / 2
max_iterations = 1000
desired_error = 0.001

ann = RubyFann::Standard.new(num_inputs: num_inputs, num_outputs: num_outputs, num_hidden: num_hidden)
ann.train_on_data(RubyFann::TrainData.new(inputs: normalized_inputs, desired_outputs: normalized_output),
                 



#########################################
require 'ruby-fann'

# Load the historical temperature, pressure, and wind data
training_data = RubyFann::TrainData.new(
  inputs: load_input_data,  # Implement this method to load the input data
  desired_outputs: load_output_data  # Implement this method to load the output data
)

# Define the neural network architecture
num_inputs = 3
num_hidden_neurons = 10
num_outputs = 1

# Create a new neural network
neural_net = RubyFann::Standard.new(
  num_inputs: num_inputs,
  hidden_neurons: [num_hidden_neurons],
  num_outputs: num_outputs
)

# Train the neural network
neural_net.train_on_data(training_data, 10000, 10, 0.1)

# Define a method to make a temperature forecast for a given date
def make_forecast(date, temperature_data, pressure_data, wind_data, neural_net)
  # Implement this method to preprocess the input data for the given date
  input = preprocess_input_data(date, temperature_data, pressure_data, wind_data)
  # Use the neural network to make a temperature forecast
  output = neural_net.run(input)
  # Return the forecasted temperature
  return output[0]
end

require 'fann'

# Define the input and output data
input_data = [
  [25.5, 1000, 10], # historical temperature, pressure, and wind data
  [24.0, 1010, 8],
  [23.5, 1005, 12],
  # ...
]
output_data = [
  [27.0], # corresponding temperature forecast for a certain date
  [26.5],
  [24.0],
  # ...
]

# Create and train the neural network
num_input = input_data.first.length
num_output = output_data.first.length
num_layers = [num_input, 10, num_output] # define the neural network architecture
ann = RubyFann::Standard.new(num_layers)
max_epochs = 1000
desired_error = 0.001
ann.train_on_data(input_data, output_data, max_epochs, 10, desired_error)

# Use the trained network to make a prediction for a new input
new_input = [27.5, 1015, 6] # historical temperature, pressure, and wind data for a new date
prediction = ann.run(new_input).first # forecasted temperature for the new date

# Print the prediction
puts "Temperature forecast for new date: #{prediction} degrees Celsius"
