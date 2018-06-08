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

#Plot 4

#Open Device
png(file = "plot4.png", width = 480, height = 480)

#clean date/time field
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
data$DateTime <- as.POSIXct(paste(data$Date, data$Time))

#Create Plot A
par(mfrow = c(2,2))
with(data, plot(DateTime, Global_active_power, type = "S", xlab = "", ylab = "Global Active Power (Kilowatt"))
#Create Plot B
with(data, plot(DateTime, Voltage, type = "S", xlab = "datetime", ylab = "Voltage"))
#Create Plot C
with(data, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy Sub Meeting"))
with(data, points(DateTime, Sub_metering_1, col = "black", type = "S"))
with(data, points(DateTime, Sub_metering_2, col = "red", type = "S"))
with(data, points(DateTime, Sub_metering_3, col = "blue", type = "S"))
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
#Create Plot D
with(data, plot(DateTime, Global_reactive_power, type = "S", xlab = "datetime", ylab = "Global_Reactive_Power"))

#turn off device
dev.off()