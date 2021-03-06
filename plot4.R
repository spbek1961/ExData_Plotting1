#Plot 4. Project 1 of Exploratory Data Analysis course.
#This script: 1-Reads data from file and  2-Creates and saves plot4 graphs.

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

message("Creating and saving plot4.png ...")
#Open png device
png(filename = "plot4.png", width = 480, height = 480, units="px")

#Draw graphs
      ##Set the layout to 4 graphs  
par(mfrow=c(2,2))
      ##Plot graph 1
with(data, plot(data$dat_tim, data$Global_active_power,type = "l", 
                      ylab="Global Active Power", xlab=""))
      ##Plot graph 2
plot(data$dat_tim, data$Voltage, type="l", xlab="datetime", 
           ylab="Voltage")
      ##Plot graph 3 
with(data, plot(data$dat_tim, data$Sub_metering_1,type = "l", 
                      ylab="Energy sub metering", xlab=""))
lines(data$dat_tim, data$Sub_metering_2, col="red") 
lines(data$dat_tim, data$Sub_metering_3, col="blue")
legend(x="topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd=2, col=c("black", "red", "blue"), bty="n")
      ##Plot graph 4
with(data, plot(dat_tim, Global_reactive_power, type="l", xlab="datetime"))
      
#Close device
dev.off()
message("Done.")