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
#Plot 4
# Open PNG device
png("Plot4.png", width = 480, height = 480)

# Plotting the first time series (e.g., Voltage)
plot(subset_data$DateTime, subset_data$Voltage, type = "l", col = "black",
     xlab = "Time", ylab = "Voltage", main = "Multiple Time Series")

# Add additional time series on the same plot
lines(subset_data$DateTime, subset_data$Global_active_power, col = "red")
lines(subset_data$DateTime, subset_data$Global_reactive_power, col = "blue")

# Close the device
dev.off()