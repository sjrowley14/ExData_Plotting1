## Week 1 Assignment

if (!file.exists("data")) {
  dir.create("data")
}

# download zip file from the internet

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./data/consumption.zip")

# unzip file
unzip('./data/consumption.zip', exdir = './data')

# read txt file, filtering for the specific dates

files <- file('./data/household_power_consumption.txt')
data <- read.table(text = grep("^[1,2]/2/2007",readLines(files),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

# Review imported data
str(data)

#Plot 1

#Open Device
png(file = "plot1.png", width = 480, height = 480)

#Create Plot
with(data, hist(Global_active_power, col = "red", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power"))

#turn off device
dev.off()