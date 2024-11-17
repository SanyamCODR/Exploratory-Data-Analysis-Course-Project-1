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
# Plot 3: Energy Sub Metering
png("Plot3.png", width = 480, height = 480)
with(subset_data, {
  plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", main = "Energy Sub Metering")
  lines(DateTime, Sub_metering_1, col = "black")  # Sub-metering 1
  lines(DateTime, Sub_metering_2, col = "red")    # Sub-metering 2
  lines(DateTime, Sub_metering_3, col = "blue")   # Sub-metering 3
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
})
dev.off()
