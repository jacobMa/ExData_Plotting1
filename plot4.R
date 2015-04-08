#plot3.R

# Download the dataset, and unzip it

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


## Retrieve the data and the description associated to the data ##
if(!file.exists("household_power_consumption.zip")){
  download.file(url,dest="household_power_consumption.zip",method="curl")
  
  #extract the contents of the zip file
  unzip("household_power_consumption.zip")
  print(" household_power_consumption.zip dataset extracted ")
}

# Read the data into a frame

data<-read.table("household_power_consumption.txt",header=T, sep=";", na.strings="?",colClasses=c("character","character",rep("numeric",7)))

#Convert the Date collumn of character type into a Date type. We do not use Time , so we will not converted.
data$Date=as.Date(data$Date, "%d/%m/%Y")

#Filter the data between 2007-02-01 and 2007-02-02 included
seek<-data[data$Date>="2007-02-01" & data$Date<="2007-02-02",]

timeformatteddates <- paste(seek$Date, seek$Time)
times <- strptime(timeformatteddates, "%Y-%m-%d %H:%M:%S")

#My language is set to German and to get R to show the week days in English I have to reset the R locale

Sys.setlocale(category="LC_ALL",locale="en_US.UTF-8")

#Open the PNG devvice
png(filename = "plot4.png", width=480, height=480)

#set layout 2x2 
par(mfcol = c(2,2))

#plot the histogram
plot(times,seek$Global_active_power, "l", xlab="", ylab="Global Active Power (kilowatts)")

#plot Sub_metering series
plot(times, seek$Sub_metering_1, "n", xlab="", ylab="Energy sub metering")
points(times, seek$Sub_metering_1, "l", col="black")
points(times, seek$Sub_metering_2, "l", col="red")
points(times, seek$Sub_metering_3, "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1)

#plot Voltage
plot(times, seek$Voltage, "l", xlab="datetime", ylab="Voltage")

#plot Global_reactive_power
plot(times, seek$Global_reactive_power, "l", xlab="datetime", ylab="Global_reactive_power")

#close the png device
dev.off()