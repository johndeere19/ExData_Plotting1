## read table with separate of ; has headers, has specified colClasses and na is ?
data <- read.table("./household_power_consumption/household_power_consumption.txt", sep=";", header = TRUE, colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

## ensure that the date is actually a date in proper format
fixdates <- paste(data$Date, data$Time, sep = " ")
data <- cbind(data, fixdates)
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$fixdates <- strptime(data$fixdates, "%d/%m/%Y %T")

## subset out only the relevant data
data <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

## subset sub meterings
subs <- c(, data$Sub_metering_2, data$Sub_metering_3)
colorvec <- c("black", "red", "blue")




## open png graphics device
png("plot4.png", width = 504, height = 504)

## paramters 2 row, 2 columns


## plot the days of week on xaxis and energy sub metering on y, lines
plot(data$fixdates, data$Sub_metering_1, type = "l", xlab="", ylab="Energy Sub Metering", col = "black")
lines(data$fixdates, data$Sub_metering_2, type = "l", col = "red")
lines(data$fixdates, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 1, col= c("black", "red", "blue"), cex = 0.7)

## end device
dev.off()