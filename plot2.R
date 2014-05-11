## read table with separate of ; has headers, has specified colClasses and na is ?
data <- read.table("./household_power_consumption/household_power_consumption.txt", sep=";", header = TRUE, colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

## ensure that the date is actually a date in proper format
fixdates <- paste(data$Date, data$Time, sep = " ")
data <- cbind(data, fixdates)
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$fixdates <- strptime(data$fixdates, "%d/%m/%Y %T")

## subset out only the relevant data
data <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

## plot the days of week on xaxis and global active power on y, lines
plot(data$fixdates, data$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")

## save as png
dev.copy(png, "plot2.png", width = 504, height = 504)
dev.off()