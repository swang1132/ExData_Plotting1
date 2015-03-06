##
## Step 1 - Loading data in data.frame
##

totalConsumption <- read.table("household_power_consumption.txt", header = T, sep = ";",  na.strings = "?", 
                               stringsAsFactors = F)

##
## Step 2 - Extract the subset based upon the selected dates
##
selectedDates <- c("1/2/2007", "2/2/2007")
selectedConsumption <- totalConsumption[totalConsumption$Date %in% selectedDates, ]

##
## Step 3 - Create a new column (DateTime) through appending Date and Time, and then convert it to POSIX date type
##
selectedConsumption $DateTime <- paste(selectedConsumption$Date, selectedConsumption$Time, sep = " ")
selectedConsumption $DateTime <- as.POSIXct(selectedConsumption$DateTime, "%d/%m/%Y %H:%M:%S", tz = "") 


##
## Step 4 - Plotting the third plot - multiple subgraphs
##
png(filename = "./figure/plot3.png", width = 480, height = 480, units = "px", pointsize = 12)

## Subgraph 1 - Sub_metering_1
plot(selectedConsumption$DateTime, selectedConsumption$Sub_metering_1, xlab = "", ylab = "Energy sub metering",
    type = "l", col="black") 

## Subgraph 2 - Sub_metering_2
lines(selectedConsumption$DateTime, selectedConsumption$Sub_metering_2, col="red") 

## Subgraph 3 - Sub_metering_3
lines(selectedConsumption$DateTime, selectedConsumption$Sub_metering_3, col="blue") 

## Legend for all subgraphs
legend("topright", c(names(selectedConsumption)[7], names(selectedConsumption)[8], names(selectedConsumption)[9]), 
       lty=c(1, 1, 1), lwd=c(2.5, 2.5, 2.5), col=c("black", "red", "blue"), horiz=F) 
dev.off()