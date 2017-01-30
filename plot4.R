## Reading the dataset
given_data_set <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

## Filtering the original dataset in order to keep what is important to us
library(dplyr)
data_i_caree_about <- filter(given_data_set, Date == "1/2/2007" | Date =="2/2/2007")

## Revoving the original dataset. It is generally good to revome what we dont need anymore (do not be a ragman)
rm(given_data_set)

## Opening the png device
png("plot4.png", width=480, height=480)

## Converting the columns Date and Time
cbind_Date_Time <- strptime(paste(data_i_caree_about$Date, data_i_caree_about$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

## The code for the fourth plot
par(mfcol = c(2, 2))  ## fills the columns first

## Top left plot
plot(cbind_Date_Time, as.numeric(data_i_caree_about$Global_active_power),
     type = "l",
     main="Global Active Power",
     ylab="Global Active Power (kilowatts)",
     xlab = "")

## Bottom left plot
plot(cbind_Date_Time, as.numeric(data_i_caree_about$Sub_metering_1),
     type = "l",
     main="Global Active Power",
     ylab="Energy Submetering",
     xlab = "")
lines(cbind_Date_Time, as.numeric(data_i_caree_about$Sub_metering_2),
      type = "l",
      col = "red")
lines(cbind_Date_Time, as.numeric(data_i_caree_about$Sub_metering_3),
      type = "l",
      col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=1, col=c("black", "red", "blue"))
       
## Top right plot
plot(cbind_Date_Time,as.numeric(data_i_caree_about$Voltage),
     type = "l",
     main="Global Active Power", 
     xlab="date time",
     ylab="Voltage")

## Bottom right plot
plot(cbind_Date_Time,as.numeric(data_i_caree_about$Global_reactive_power),
     type = "l",
     main="Global Reactive Power", 
     xlab="date time",
     ylab="Voltage")
                  
             
## Closing the png device
dev.off()  

## THE END
