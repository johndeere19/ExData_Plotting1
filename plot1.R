## read table with separate of ; has headers, has specified colClasses and na is ?
data <- read.table("./household_power_consumption/household_power_consumption.txt", sep=";", header = TRUE, colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

## ensure that the date is actually a date in proper format
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## subset out only the relevant data
data <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

## build a histogram
with(data, hist(Global_active_power, col = "red", main="Global Active Power", xlab = "Global Active Power (kilowatts)"), xlim = c(0,6), ylim = c(0,1200))

## save as png
dev.copy(png, "plot1.png", width = 504, height = 504)
dev.off()