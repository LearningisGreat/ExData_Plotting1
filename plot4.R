# Download data
assign_Url <-
  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(assign_Url, "zipped_file", method = "curl")

unzip("zipped_file")

# Format Data

df <- read.csv2("household_power_consumption.txt")

str(df)

df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

df1 <- subset(df, df$Date >= "2007-02-01" & df$Date <= "2007-02-02")
df1$DateTime <-
  as.vector(strptime(paste0(df1$Date, " ", df1$Time), format = "%Y-%m-%d %H:%M:%S"))

df1$Global_active_power <- as.numeric(df1$Global_active_power)

# Plot Data

png(filename = "plot4.png")

par(mfrow = c(2,2), cex = 0.4)

plot(
  df1$DateTime,
  df1$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)

plot(df1$DateTime,
     df1$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage"
)

plot(
  df1$DateTime,
  df1$Sub_metering_1,
  type = "l",
  ylab = "Energy sub metering",
  xlab = ""
)
lines(df1$DateTime,
      df1$Sub_metering_2,
      type = "l",
      col = "red")
lines(df1$DateTime,
      df1$Sub_metering_3,
      type = "l",
      col = "blue")
legend(
  "topright",
  legend = names(df1)[grep(names(df1), pattern = "Sub_met")],
  col = c("black", "red", "blue"),
  lty = 1,
  cex = 1.5
)

plot(
  df1$DateTime,
  df1$Global_reactive_power,
  pch = 20,
  cex = 0.7,
  ylab = "Global_Reactive_Power",
  xlab = "datetime"
)
lines(df1$DateTime, df1$Global_reactive_power)


dev.off()
