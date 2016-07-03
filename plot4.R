# Coursera Data Science Specialization - Exploratory Data Analysis
# plot4.R

## Download the dataset into data folder and remove dataset zip file

file <- "./data/household_power_consumption.txt"

if(!file.exists(file)) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "dataset.zip", mode = "wb")
        unzip("dataset.zip", exdir = "data")
        unlink("dataset.zip")
}

## Determine system limits and read in the dataset

### Rough calculation of memory required to store the dataset
### 2,075,259 rows and 9 columns, assume all numeric
### ((2075259 * 9 * 8) / (2 ** 20)) = 142.50 MB
### Memory is sufficient

dataset <- read.table(file, header = TRUE, sep = ";")

## Subset the dataset for required dates
## Update classes of Date and Time variables for plotting

dataset_sub <- subset(dataset, Date == "1/2/2007" | Date == "2/2/2007")
dataset_sub$DateTime <- paste(dataset_sub$Date, dataset_sub$Time)
dataset_sub$DateTime <- strptime(dataset_sub$DateTime, "%d/%m/%Y %H:%M:%S")

## Converting other variables for plotting

dataset_sub$Global_active_power <- as.numeric(as.character(dataset_sub$Global_active_power))
dataset_sub$Sub_metering_1 <- as.numeric(as.character(dataset_sub$Sub_metering_1))
dataset_sub$Sub_metering_2 <- as.numeric(as.character(dataset_sub$Sub_metering_2))
dataset_sub$Sub_metering_3 <- as.numeric(as.character(dataset_sub$Sub_metering_3))
dataset_sub$Voltage <- as.numeric(as.character(dataset_sub$Voltage))

# Initializing plot settings

plot.new()
par(mfrow = c(2, 2), mar = c(5.1, 4, 3, 2.1))

## Creating the plot

### Top left plot

plot(dataset_sub$DateTime, dataset_sub$Global_active_power, type = "l", 
     xlab = NA, ylab = "Global Active Power")

### Top right plot

plot(dataset_sub$DateTime, dataset_sub$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

### Bottom left plot

plot(dataset_sub$DateTime, dataset_sub$Sub_metering_1, type = "n", xlab = NA, 
     ylab = "Energy sub metering")

lines.default(dataset_sub$DateTime, dataset_sub$Sub_metering_1, col = "black")
lines.default(dataset_sub$DateTime, dataset_sub$Sub_metering_2, col = "red")
lines.default(dataset_sub$DateTime, dataset_sub$Sub_metering_3, col = "blue")

legend("topright", col = c("black", "red", "blue"), lty = c(1, 1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.6, bty = "n")

### Bottom right plot

plot(dataset_sub$DateTime, as.character(dataset_sub$Global_reactive_power), type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")

## Copy to PNG file
dev.copy(png, file = "plot4.png")
dev.off()
