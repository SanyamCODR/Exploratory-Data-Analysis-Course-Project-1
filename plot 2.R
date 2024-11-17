# Load the necessary library
library(data.table)

# Load the data
data <- fread("household_power_consumption.txt", sep = ";")

# Convert the Date and Time into proper datetime objects
data[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Subset the data for the specific days
subset_data <- data[DateTime %between% as.POSIXct(c("2007-02-01", "2007-02-02"))]

# Ensure Global_active_power is numeric and handle NA values
subset_data[, Global_active_power := as.numeric(Global_active_power)]
subset_data <- na.omit(subset_data)

# Open PNG device
png("Plot2.png", width = 480, height = 480)

# Plot 2
#Plotting the time series of Global Active Power
if (length(subset_data$DateTime) == length(subset_data$Global_active_power)) {
  plot(subset_data$DateTime, subset_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", main = "Global Active Power over Time")
} else {
  message("DateTime and Global Active Power lengths differ or contain NA values.")
}
