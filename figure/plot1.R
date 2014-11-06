


base_dir=""

# filter data after import
startDate <- '01/02/2007'
endDate <- '02/02/2007'
startDate <-as.Date(startDate,format="%d/%m/%Y")
endDate <-as.Date(endDate,format="%d/%m/%Y")

# sample structure
# Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
# 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000

# input and output file names
file<-paste(base_dir,"household_power_consumption.txt",sep='')
pngfile<-paste(base_dir,"plot1.png",sep='')


# using data from the dates 2007-02-01 and 2007-02-02.
`z` <- read.table(file, 
                  header = TRUE,
                  strip.white=TRUE,
                  blank.lines.skip=TRUE,
                  row.names=NULL,
                  na.strings = '?',
                  fill=TRUE, 
                  as.is = TRUE,
                  stringsAsFactors=F,
                  sep = ";") 

# format date after import to compare
z$Date<-as.Date(z$Date,format="%d/%m/%Y")

# filter data by Feb 2007 dates inclusive
z <- z[(z$Date >= startDate & z$Date <= endDate) ,]

# save for converting later as dateTime
dateTime <- paste(z$Date,z$Time)
dateTime <- strptime(dateTime,format='%Y-%m-%d %H:%M:%S')

z$Global_active_power<-as.numeric(z$Global_active_power)

# print to image of 480x480 pixels
png(pngfile,
    width     = 480,
    height    = 480,
    units     = "px")
hist(z$Global_active_power,
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     main="Global Active Power",
     col="red",         # colors
     cex.main=0.9,cex.lab=0.75,cex.axis=0.75) # font sizes
dev.off() # shut down
