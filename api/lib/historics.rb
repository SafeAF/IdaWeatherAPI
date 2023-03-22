require 'rover-df'

############## Historics #############

def historical_daily_low(data, month, day, dependent_var)
data[(data["month"] == month) &
(data["day"] == day)][dependent_var].min
end

def historical_daily_high(data, month, day, dependent_var)
data[(data["month"] == month) &
(data["day"] == day)][dependent_var].max
end


def historical_average_for_hour(data, month, day, hour, dependent_var)
data[(data["month"] == month) &
(data["day"] == day) &
    (data["hour"] == hour)][dependent_var].mean
end

def historical_average_for_day(data, month, day, dependent_var)
data[(data["month"] == month) &
    (data["day"] == day)][dependent_var].mean
end

def calculate_historics(frames)
historic_low = historical_daily_low(frames,
    Time.new.month, Time.new.day, "temperature")
historic_high = historical_daily_high(frames,
    Time.new.month, Time.new.day, "temperature")
historic_hour = historical_average_for_hour(frames,
    Time.new.month, Time.new.day, Time.new.hour, "temperature")
{historic_low: historic_low, historic_high: historic_high,
    historic_hour: historic_hour}
end