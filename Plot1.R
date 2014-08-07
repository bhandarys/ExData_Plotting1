## Download the file if it does not exist, download and Unzip
if(!file.exists("household_power_consumption.txt")){
  if(!file.exists("destFile.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "destFile.zip")
  }
  unzip("destFile.zip")
}

## Read the file into the variable d (DataSet)
d <- read.csv("~/household_power_consumption.txt", sep=";", na.strings = c("", "?", "NA", header=T))

## Convert Date and time into correct format and create a new column with appropriate name. dt stands for DataTime
dt <- strptime(paste(d$Date,d$Time), "%d/%m/%Y %H:%M:%S")
dt<-data.frame(dt)
colnames(dt) <- "Date"

## bind it to the variable d which holds all the values. dn stands for DataNew
dn <- cbind(dt, d$Global_active_power)

## filter out all data expect for the 2 days. df stands for DataFinal
df <- dn[(dn$Date >= as.POSIXlt("2007-02-01 00:00:00") & dn$Date < as.POSIXlt("2007-02-03 00:00:00")),]

##Make sure you have only one frame for the graph
par(mfcol=c(1,1))

## draw the histograms
hist(df[,2], col = "red", border = "black", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")

## Write it as a png file
dev.copy(png, file ="plot1.png")
dev.off()