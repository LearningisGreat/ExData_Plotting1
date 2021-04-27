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

# Plot1.png

png(filename = "plot1.png")

hist(
  df1$Global_active_power,
  col = "red",
  main = "Global Active Power",
  ylab = "Frequency",
  xlab = "Global Active Power (kilowatts)"
)

dev.off()