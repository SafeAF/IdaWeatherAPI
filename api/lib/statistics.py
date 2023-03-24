import pandas as pd

def hourly_one_month_data(data, year, month, dependent_var):
    independent_var = "time_index"
    raw_hours = data[(data["year"] == year) & (data["month"] == month)]
    sliced_hours = raw_hours[[independent_var, dependent_var]]
    
    coords = []
    counter = 1
    for index, row in sliced_hours.iterrows():
        coords.append({"x": counter, "y": row[dependent_var]})
        counter += 1
        
    return coords

def monthly_average(data, year, dependent_var):
    averages = []
    for month in range(1, 13):
        month_data = data[(data["year"] == year) & (data["month"] == month)]
        averages.append({"x": month, "y": month_data[dependent_var].mean()})
    return averages

def compare_months_across_years(data, start_year, end_year, month, dependent_var, method):
    graph_data = []
    for year in range(start_year, end_year+1):
        graph_data.append({"x": year, "y": one_month_function(data, year, month, dependent_var, method)})
    return graph_data

def one_month_function(data, year, month, dependent_var, method):
    return getattr(data[(data["year"] == year) & (data["month"] == month)][dependent_var], method)()

def yearly_range(data, start_year, end_year, dependent_var, method):
    graph_data = []
    for year in range(start_year, end_year+1):
        graph_data.append({"x": year, "y": yearly_function(data, year, dependent_var, method)})
    return graph_data

def yearly_function(data, year, dependent_var, method):
    return getattr(data[(data["year"] == year)][dependent_var], method)()

def year_by_month_function(data, year, dependent_var, method):
    averages = []
    for month in range(1, 13):
        month_data = data[(data["year"] == year) & (data["month"] == month)]
        averages.append({"x": month, "y": getattr(month_data[dependent_var], method)()})
    return averages
