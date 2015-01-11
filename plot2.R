#Plot 2. Project 1 of Exploratory Data Analysis course.
#This script: 1-Reads data from file and  2-Creates and saves plot2 graph.

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
message("Creating and saving plot2.png ...")

#Open png device
png(filename = "plot2.png", width = 480, height = 480, units="px")

#Draw graph
with(data, plot(data$dat_tim, data$Global_active_power,type = "l", 
                ylab="Global Active Power (kilowatts)", xlab=""))
#Close device
dev.off()
message("Done.")