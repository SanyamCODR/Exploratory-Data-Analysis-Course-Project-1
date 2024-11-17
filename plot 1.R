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
png("Plot1.png", width = 480, height = 480)

# Plotting the histogram of Global Active Power
hist(subset_data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red", breaks = 50)

# Close the device
dev.off()
