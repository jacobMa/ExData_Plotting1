#plot1.R

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

#Open the PNG devvice
png(filename = "plot1.png", width=480, height=480)

#plot the histogram
hist(seek$Global_active_power,col="red", freq=T, main="Global Active Power", xlab="Global Active Power (kilowatts)")

#close the png device
dev.off()