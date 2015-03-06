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
## Step 3 -  Create a new column (DateTime) through appending Date and Time, and then convert it to POSIX date type
##
selectedConsumption $DateTime <- paste(selectedConsumption$Date, selectedConsumption$Time, sep = " ")
selectedConsumption $DateTime <- as.POSIXct(selectedConsumption$DateTime, "%d/%m/%Y %H:%M:%S", tz = "")

##
## Step 4 - Plotting the fourth plot - Mutiple charts in one page
##
png(filename = "./figure/plot4.png", width = 480, height = 480, units = "px", pointsize = 12)
par(mfrow=c(2,2))

## Chart 1 - Global Active Power
plot(selectedConsumption$DateTime, selectedConsumption$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "") 

## Chart 2 - Voltage
plot(selectedConsumption$DateTime, selectedConsumption$Voltage, type = "l", ylab = "Voltage", xlab = "datetime") 

## Chart 3 - Energy Sub Metering
plot(selectedConsumption$DateTime, selectedConsumption$Sub_metering_1, xlab = "", ylab = "Energy sub metering",
     type = "l", col="black")
lines(selectedConsumption$DateTime, selectedConsumption$Sub_metering_2, col="red") 
lines(selectedConsumption$DateTime, selectedConsumption$Sub_metering_3, col="blue") 
legend("topright", c(names(selectedConsumption)[7], names(selectedConsumption)[8], names(selectedConsumption)[9]), 
       lty=c(1, 1, 1), lwd=c(2.5, 2.5, 2.5), col=c("black", "red", "blue"), bty = "n", horiz=F) 

## Chart 4 - Global_reactive_power
plot(selectedConsumption$DateTime, selectedConsumption$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime") 

dev.off()