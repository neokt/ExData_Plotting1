# Coursera Data Science Specialization - Exploratory Data Analysis
# plot2.R

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

## Initializing plot settings

plot.new()
par(mfrow = c(1, 1), mar = c(5.1, 4, 3, 2.1))

## Creating the plot

plot(dataset_sub$DateTime, dataset_sub$Global_active_power, type = "l", xlab = NA, 
     ylab = "Global Active Power (kilowatts)")

## Copy to PNG file

dev.copy(png, file = "plot2.png")
dev.off()