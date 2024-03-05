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
png(filename = "Plot1.png", width = 480, height = 480, units = "px")
hist(my_data$Global_active_power, col = "red", xlim = c(0, 8),
     ylim = c(0, 1300), main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()






