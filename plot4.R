
#This function reads a compressed csv file and creates a plot

library(lubridate)

#Specify the location of the file
loc_zipfile <- './exdata_data_household_power_consumption.zip'

#readData takes the location of the zip file
readData <- function(loc_zipfile){
    
    #read the data
    rawData <- read.table(unz(loc_zipfile, 'household_power_consumption.txt'), 
                          header=T, sep=';', stringsAsFactors = F, na.strings = '?')
    
    #extract the needed columns
    hpc <- subset(rawData, (Date=='1/2/2007' | Date=='2/2/2007'))
    
    #convert Date column to a date format
    #same for time
    hpc$DateTime <- dmy_hms(paste(hpc$Date, hpc$Time))
    
    hpc
}

#Reads the returned object of the readData function
#Creates plot4.png
createPlot4 <- function(hpc){
    
    #creates 2 rows and 2 columns to combine the plots
    par(mfrow=c(2,2))
    
    #first plot
    plot(hpc$DateTime, hpc$Global_active_power, type='l', 
         ylab='Global Active Power (kilowatts)', xlab='Days')
    
    #second plot
    plot(hpc$DateTime, hpc$Voltage, type='l', 
         ylab='Voltage', xlab='datetime')
    
    #third plot
    plot(hpc$DateTime, hpc$Sub_metering_1, type='l', xlab='Days', 
         ylab='Energy sub metering')
    lines(hpc$DateTime, hpc$Sub_metering_2, col='red')
    lines(hpc$DateTime, hpc$Sub_metering_3, col='blue')
    legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
           col=c('black','red', 'blue'), lty=1, cex=0.5)
    
    #fourth plot
    plot(hpc$DateTime, hpc$Global_reactive_power, type='l', 
         ylab='Voltage', xlab='datetime')
    
    dev.copy(png, file='plot4.png')
    dev.off()
    
}

#run

hpc <- readData(loc_zipfile)

createPlot4(hpc)
