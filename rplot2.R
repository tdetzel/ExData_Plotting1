## plot2.R -- an update of code for Exploratory Data Analysis plotting assignment

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

## code for plot 2
png(filename="plot2.png", width=480, height=480, type="quartz")
with(powerFeb, plot(Global_active_power, type='l', axes=F, ylab='Global Active Power (kilowatts)', xlab=""))
with(powerFeb, axis(side=2, at=c(0,2,4,6)))
with(powerFeb, axis(side=1, at=c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat")))
dev.off()
