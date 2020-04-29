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
    hpc$Date <- dmy(hpc$Date); hpc$Time <- hms(hpc$Time)
    
    #return dataframe for plotting
    hpc
}

#Reads the returned object of the readData function
#Creates plot1.png
createPlot1 <- function(hpc){
    
    #plots histogram
    hist(hpc$Global_active_power, col='red', 
         xlab='Global Active Power (kilowatts)', main='Global Active Power')
    
    dev.copy(png, file='plot1.png')
    dev.off()

}

#run

hpc <- readData(loc_zipfile)

createPlot1(hpc)
