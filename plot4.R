## read table with separate of ; has headers, has specified colClasses and na is ?
data <- read.table("./household_power_consumption/household_power_consumption.txt", sep=";", header = TRUE, colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

## ensure that the date is actually a date in proper format
fixdates <- paste(data$Date, data$Time, sep = " ")
data <- cbind(data, fixdates)
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$fixdates <- strptime(data$fixdates, "%d/%m/%Y %T")

## subset out only the relevant data
data <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

## open png graphics device
png("plot4.png", width = 480, height = 480)

## paramters 2 row, 2 columns
par(mfrow=c(2,2))

## global active power kwatts
plot(data$fixdates, data$Global_active_power, type = "l", xlab="", ylab="Global Active Power")

## voltage 
plot(data$fixdates, data$Voltage, type = "l", xlab="datetime", ylab="Voltage")

## plot the days of week on xaxis and energy sub metering on y, lines
plot(data$fixdates, data$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering", col = "black")
lines(data$fixdates, data$Sub_metering_2, type = "l", col = "red")
lines(data$fixdates, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 1, col= c("black", "red", "blue"), cex = 0.7, bty = "n")

## 
plot(data$fixdates, data$Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power")

## end device
dev.off()