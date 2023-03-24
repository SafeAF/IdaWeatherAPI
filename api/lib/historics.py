import pandas as pd
import datetime

############## Historics #############

def historical_daily_low(data, month, day, dependent_var):
    return data[(data["month"] == month) & (data["day"] == day)][dependent_var].min()

def historical_daily_high(data, month, day, dependent_var):
    return data[(data["month"] == month) & (data["day"] == day)][dependent_var].max()

def historical_average_for_hour(data, month, day, hour, dependent_var):
    return data[(data["month"] == month) & (data["day"] == day) & (data["hour"] == hour)][dependent_var].mean()

def historical_average_for_day(data, month, day, dependent_var):
    return data[(data["month"] == month) & (data["day"] == day)][dependent_var].mean()

def calculate_historics(frames):
    now = datetime.datetime.now()
    historic_low = historical_daily_low(frames, now.month, now.day, "temperature")
    historic_high = historical_daily_high(frames, now.month, now.day, "temperature")
    historic_average = historical_average_for_hour(frames, now.month, now.day, now.hour, "temperature")
    return {"historic_low": historic_low, "historic_high": historic_high, "historic_average": historic_average}
