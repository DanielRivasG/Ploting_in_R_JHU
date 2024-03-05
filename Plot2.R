# load libraries
library(tidyverse)
library(here)

# download data
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (file.exists("data") == FALSE) {
  download.file(url = URL, destfile = "data.zip")
}

# read data
df <- read_delim(file = here("data.zip"), delim = ";", na = c("\\?", "", "NA"),
                 locale = locale(decimal_mark = ".", grouping_mark = ","),
                 col_types = cols(
                   col_date(format = "%d/%m/%Y"),
                   col_time(),
                   col_double(),
                   col_double(),
                   col_double(),
                   col_double(),
                   col_double(),
                   col_double(),
                   col_double())
)

# filter only the data I need
my_data <- filter(df, Date == "2007-02-01" | Date == "2007-02-02") %>%
  mutate(Date_Time = as.POSIXct(paste(Date, Time, sep = "")))
rm(df)


# plot code
png(filename = "Plot2.png", width = 480, height = 480, units = "px")
plot(my_data$Date_Time, y = my_data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)", axes = F)
box(); axis(2)
axis(1, at = c(1170309600, 1170396000, 1170482400), labels = c("Thu", "Fri", "Sat"))

dev.off()


