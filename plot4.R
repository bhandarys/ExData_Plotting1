## Download the file if it does not exist, download and Unzip
if(!file.exists("household_power_consumption.txt")){
  if(!file.exists("destFile.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "destFile.zip")
  }
  unzip("destFile.zip")
}

## Read the file into the variable d (DataSet)
d <- read.csv("~/household_power_consumption.txt", sep=";", na.strings = c("", "?", "NA", header=T))

## bind it to the variable d which holds all the values. dn stands for DataNew
dt <- strptime(paste(d$Date,d$Time), "%d/%m/%Y %H:%M:%S")
dt<-data.frame(dt)
colnames(dt) <- "Date"
dn <- cbind(dt, d)

## filter out all data expect for the 2 days. df stands for DataFinal
df <- dn[(dn$Date >= as.POSIXct("2007-02-01 00:00:00") & dn$Date < as.POSIXct("2007-02-03 00:00:00")),]

## 4 frames for the graph
par(mfcol=c(2,2))

## plot graph 1
with(df, plot(df[,1], df[,4], type="l", ylab = "Global Active Power", xlab = "", cex.axis = .7))

## 2
with(df, plot(df[,1], df[,8], type="l", ylab = "Energy sub metering", xlab = "", cex.axis = .7))
lines(df[,1], df[,9], pch=20, type="l", col="red")
lines(df[,1], df[,10], pch=20, type="l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(5,5,5), lwd=c(1,1,1), col = c("black", "red", "blue"), cex = .6, y.intersp = .3, xjust = 1, text.width = 40000, bty="n")

## 3
plot(df[,1], df[,6], type="l", ylab = "Voltage", xlab = "datetime", cex.axis = .7)

## 4
plot(df[,1], df[,5], type="l", ylab = "Global_reactive_power", xlab = "datetime", cex.axis = .6)

## Save the plot
dev.copy(png, file ="plot4.png")
dev.off()
