# Load Electric Power Consumption data set into r.
hh.power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Change Date column values from a charactor to a date object.
hh.power$Date<- as.Date(hh.power$Date, format= "%d/%m/%Y")

# Subset the data associated with February 1 & 2, 2007 from the master file.
hh.sub <- subset(hh.power, Date == as.Date("2007-2-1") | Date == as.Date("2007-2-2"))

# Create a new column called "date.time" that merges the "Date" & "Time" columns.
# The new column is a POSIXct object.
hh.sub$date.time <- as.POSIXct(paste(hh.sub$Date, hh.sub$Time), format = "%Y-%m-%d %H:%M:%S")

# Set the graphical parameters so the plot will be a square.
par(pin = c(6, 6))

# Create line graph with Sub_metering_1 values then add sub_metering_2 & sub_metering_3 to graph.
with(hh.sub, plot(date.time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", typ ="l"))
with(hh.sub,lines(date.time, Sub_metering_2, typ = "l", col = "red"))
with(hh.sub,lines(date.time, Sub_metering_3, typ = "l", col = "blue"))

# Create graph legend.
legend("topright", lwd = 1, lty = 1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Copy line graph to a png file. Pixel size default is 480 x 480.
dev.copy(png,'plot3.png')
dev.off()