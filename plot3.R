## plot3.R -- code for coursera plotting assignment

## plotting code is lower down
## set working directory
## optional check for directory
## if (!file.exists("Data")) {
##  dir.create("Data")
##  }

setwd("../Data")

## download data (but this is really slow; better to do outside R)
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "../Data/power.zip"
download.file(fileUrl, destfile, method = "curl")

## check result
list.files("../Data")
dateDownloaded <- date()

## read the data
library(data.table)
power <- fread("power.txt", header=T, sep=";", na.strings='?', showProgress=T)

## subset to get data from Feb. 1-2
powerFeb <- data.frame(subset(power, Date%in%c("1/2/2007", "2/2/2007")))

## fix data types
powerFeb$Date <- strptime(powerFeb$Date, format = '%d/%m/%Y')
powerFeb$Time <- strptime(powerFeb$Time, format = '%H:%M:%S')
powerFeb[,c(3:9)] <- sapply(powerFeb[, c(3:9)], as.numeric, simplify=T)

## check
str(powerFeb)
head(powerFeb)
tail(powerFeb)

## code for plot 3
png(filename="plot3.png", width=480, height=480, type="quartz")
with(powerFeb, plot(Sub_metering_1, type='l', frame.plot=T, axes=F, ylab='Energy sub metering', xlab="", col="red"))
with(powerFeb, points(Sub_metering_2, type='l', col="orange"))
with(powerFeb, points(Sub_metering_3, type='l', col="blue"))
with(powerFeb, axis(side=2, at=c(0,10,20,30)))
with(powerFeb, axis(side=1, at=c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat")))
legend("topright", col=c("red", "orange", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), xjust=1, yjust=1, lty=1, lwd=2, cex=.7)
dev.off()

