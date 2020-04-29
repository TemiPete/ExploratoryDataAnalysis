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
    
    #return dataframe for plotting
    hpc
}

#Reads the returned object of the readData function
#Creates plot3.png
createPlot3 <- function(hpc){
    
    #line plot
    plot(hpc$DateTime, hpc$Sub_metering_1, type='l', xlab='Days', 
         ylab='Energy sub metering')
    lines(hpc$DateTime, hpc$Sub_metering_2, col='red')
    lines(hpc$DateTime, hpc$Sub_metering_3, col='blue')
    
    legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
           col=c('black','red', 'blue'), lty=1)
    
    dev.copy(png, file='plot3.png')
    dev.off()
}

#run

hpc <- readData(loc_zipfile)

createPlot3(hpc)
