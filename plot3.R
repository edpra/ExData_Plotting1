# plots3.R
#
# Plot three lines on the same graph for sub_metering_1,2, and 3 data
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
dt = dt %>% 
    mutate(Time = as.POSIXct(strptime(paste0(Date," ", Time), "%d/%m/%Y %H:%M:%S"))) %>%
    mutate(Date = as.Date(Date, "%d/%m/%Y"))
    
png(file="plot3.png", width=480, height=480)
with(dt, {
    plot(Time, Sub_metering_1, type="l", col="darkblue", xlab="", ylab="Energy sub metering")
    lines(Time, Sub_metering_2, col="red")
    lines(Time, Sub_metering_3, col="blue")
})
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("darkblue", "red", "blue"), lty=1)
dev.off()
