require 'rover-df'

def hourly_one_month_data(data,
    year, month, dependent_var)
  
    independent_var = "time_index"
    raw_hours = data[
      (data["year"] == year) & (data["month"] == month)
      ]
  
    sliced_hours = raw_hours[[independent_var, dependent_var]]
    # coords.rename("#{independent_var}": "x")
    # coords.rename("#{dependent_var}": "y")
    
    coords = []
    counter = 1
    sliced_hours.each_row do |row|
      coords << {x: counter, y: row[dependent_var]}
      counter += 1
      #coords << {x: row["time_index"], y: row[dependent_var]}
    end
    return coords
    #return raw_hours[["time_index", dependent_var]].to_a
  end
  
  
  def monthly_average(data, year, dependent_var)
    averages = []
    (1..12).each do |month|
     month_data = data[(data["year"] == year) & (data["month"] == month)]
     averages << {x: month, y: month_data[dependent_var].mean }
    end
    averages
  end
  
  ### Rewrites ###
  def compare_months_across_years(data, start_year, end_year,
     month, dependent_var, method)
    graph_data = []
    (start_year .. end_year).each do |year|
        graph_data << {x: year,
            y: one_month_function(data, year, month, dependent_var, method)}
    end
    graph_data
  end
  
  def one_month_function(data, year, month, dependent_var, method)
    data[
      (data["year"] == year) & 
      (data["month"] == month)][dependent_var].send(method)
  end
  
  
  def yearly_range(data, start_year, end_year, dependent_var, method)
    graph_data = []
    (start_year .. end_year).each do |year|
      graph_data << {x: year,
         y: yearly_function(data, year, dependent_var, method )}
    end
    graph_data
  end
  
  # runs a method on a particular year for a specified dep var
  # returns float
  def yearly_function(data, year, dependent_var, method)
    data[(data["year"] == year)][dependent_var].send(method)
  end
  
  
  # runs a method (ex. min max or mean) on a particular year
  # for a particular variable for each month in that year
  # returns [{x: month y: dep_var.method}, ...]
  def year_by_month_function(data, year, dependent_var, method)
    averages = []
    (1..12).each do |month|
  
     month_data = data[(data["year"] == year) &
      (data["month"] == month)]
  
     averages << {x: month,
       y: month_data[dependent_var].send(method) }
    end
    averages
  end