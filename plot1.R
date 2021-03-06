#Plot1. Project 1 of Exploratory Data Analysis course.
#This script: 1-Reads data from file and  2-Creates ans saves plot1 graph.

#############################################################################
## 1 - Reads household_power_consumption table, creates a POSIX date-time
## column and subsets the data to build the required graph. This script and 
## the file household_power_consumption.txt should be in the same directory.
#############################################################################
message("Reading data ...")
tmp <- read.table("./household_power_consumption.txt",header = TRUE, sep = ";",
                  na.strings="?")

 #Converting Date and Time fields to data type and merging into dat_tim
message("Converting Date and Time fields to POSIX format ...")
dat_tim <-paste(tmp$Date, tmp$Time)
dat_tim <-strptime(dat_tim, "%d/%m/%Y %H:%M:%S")
tmp <- cbind(tmp, dat_tim)
remove(dat_tim)
 #subset data needed from 01/02/2007 and 02/02/2007
message("Extracting data for the graphs ...")
data=tmp[tmp$Date=="1/2/2007" | tmp$Date=="2/2/2007",]
remove(tmp)

##############################################################################
## 2 - Creates graphic and saves plots
##############################################################################
message("Creating and saving plot1.png ...")

#Open png device
png(filename = "plot1.png", width = 480, height = 480, units="px")

#Draw the histogram
with(data, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))

#Close device
dev.off()
message("Done.")