# Load Electric Power Consumption data set into r.
hh.power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Change Date column values from a charactor to a date object.
hh.power$Date<- as.Date(hh.power$Date, format= "%d/%m/%Y")

# Subset the data associated with February 1 & 2, 2007 from the master file.
hh.sub <- subset(hh.power, Date == as.Date("2007-2-1") | Date == as.Date("2007-2-2"))

# Create a new column called "date.time" that merges the "Date" & "Time" columns.
# The new column is a POSIXct object.
hh.sub$date.time <- as.POSIXct(paste(hh.sub$Date, hh.sub$Time), format = "%Y-%m-%d %H:%M:%S")

# Change the class of Global_active_power from charactor to number.
hh.sub$Global_active_power <- as.numeric(hh.sub$Global_active_power)

# Set the graphical parameters so the plot will be a square.
par(pin = c(2, 2))

# Adjust graphical parameters so 4 graphs can be displayed.
# Graphs will display left to right then top to bottom.
par(mfrow = c(2,2))

# Create a line graph that shows Global Active Power over time.
plot(x = hh.sub$date.time, y = hh.sub$Global_active_power, typ = "l", ylab = "Global Active Power", xlab = "")

# Create a line graph that shows Voltage over time.
plot(x = hh.sub$date.time, y = hh.sub$Voltage, typ = "l", ylab = "Voltage", xlab = "datetime")

# Create line graph with Sub_metering_1 values then add sub_metering_2 & sub_metering_3 to graph.
with(hh.sub, plot(date.time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", typ ="l"))
with(hh.sub,lines(date.time, Sub_metering_2, typ = "l", col = "red"))
with(hh.sub,lines(date.time, Sub_metering_3, typ = "l", col = "blue"))

# Create line that shows Global Reactive Power over time.
with(hh.sub, plot(date.time, Global_reactive_power, typ = "l"))

# Copy line graph to a png file. Pixel size default is 480 x 480.
dev.copy(png,'plot4.png')
dev.off()