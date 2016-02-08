# plot1.R
#
# Plot a histogram for Global Active Power data
# Data include two days of power consumption metering from UCI.
#

library(data.table)
library(dplyr)

filename = "household_power_consumption.txt"

##################################################
# Download and unzip file for processing
if (!file.exists(filename)) {
    localzip = "HPC.zip"
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", localzip, method = "curl")
    unzip(localzip)
    unlink(localzip) # remove the uneeded big zip file
}

readOnDates <- function(d1, d2) {
    fread(paste0("head -n 1 ", filename, "; grep '^", d1, "\\|^", d2, "' ", filename), 
          sep=";", na.strings="?")
}

# Only load data for two dates
dt = readOnDates("1/2/2007", "2/2/2007")

# Convert date from "15/12/2006" to "2006-12-15"
#dt = dt %>% 
#    mutate(Time = as.POSIXct(strptime(paste0(Date," ", Time), "%d/%m/%Y %H:%M:%S"))) %>%
#    mutate(Date = as.Date(Date, "%d/%m/%Y"))

png(file="plot1.png", width=480, height=480)
hist(dt$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
