## Reading the dataset
given_data_set <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

## Filtering the original dataset in order to keep what is important to us
library(dplyr)
data_i_caree_about <- filter(given_data_set, Date == "1/2/2007" | Date =="2/2/2007")

## Revoving the original dataset. It is generally good to revome what we dont need anymore (do not be a ragman)
rm(given_data_set)

## Opening the png device
png("plot1.png", width=480, height=480)

## The code for the first plot
hist(as.numeric(data_i_caree_about$Global_active_power),     
                main="Global Active Power", 
                xlab="Global Active Power (kilowatts)",
                ylab="Frequency", 
                col="red")
                
## Closing the png device
dev.off()  
