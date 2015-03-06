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
## Step 4 - Plotting the second plot - Line chart
##
png(filename = "./figure/plot2.png", width = 480, height = 480, units = "px", pointsize = 12)
plot(selectedConsumption$DateTime, selectedConsumption$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "") 
dev.off()