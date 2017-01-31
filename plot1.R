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
png("plot1.png", width=480, height=480)

## The code for the first plot
hist(data1$Global_active_power,     
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency", 
     col="red")

## Closing the png device
dev.off() 

## THE END
