## loading the libraries we need
pacman::p_load(data.table, dplyr, magrittr, lubridate)

## Setting the working directory
setwd("D:/portofolio/R Programming/Exploratory Data Analysis")

## Download and unzip the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./household_power_consumption.zip")
file <- unzip("./household_power_consumption.zip")

## Reading the data
data1 <- fread(file, na.strings = "?",
              colClasses = c("date","time","integer","integer","integer","integer","integer","integer","integer"))

## An alternaive way of reading them
## data <- read.table(text = grep("^[1,2]/2/2007",readLines(file),value=TRUE), na.strings = '?', sep = ';',
##                   c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
##                   "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
 
## Put the data in a tibble
data1 <- tbl_df(data1)  %>%    
## Filtering the dataset in order to keep the subset we need
filter(Date == "1/2/2007" | Date =="2/2/2007")  %>%
## Merging the columns Date and Time in a single column
mutate(date_time = (paste(Date, Time, sep=" "))) %>%
## Getting rid of them
select(- Date, - Time)
  ## Converting the date_time column from character to POSIX [you can confirm with the function class(data2$date_time)]
  data1$date_time <- dmy_hms(data1$date_time)

## PGN - Plot  ---------------------------------------------------------------------------------------------------------
## Opening the png device
png("plot3.png", width=480, height=480)

## The code for the third plot
plot(data1$date_time, data1$Sub_metering_1,
     type = "l",
     main="Global Active Power",
     ylab="Energy Submetering",
     xlab = "")
lines(data1$date_time, data1$Sub_metering_2,
      type = "l",
      col = "red")
lines(data1$date_time, data1$Sub_metering_3,
      type = "l",
      col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=1, col=c("black", "red", "blue"))

## Closing the png device
dev.off()  

## THE END
