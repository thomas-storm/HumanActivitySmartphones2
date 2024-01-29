## Peer-graded Assignment: Exploratory Data Analysis Course Project 2
## Plot2

library(dplyr)

## set main directory and "data" sub directory
## requires working directory is set correctly
main_dir <- getwd()
sub_dir <- "data"

## check if "data" sub-directory exists, if not download and unzip files in data folder
if (!dir.exists(sub_dir)){
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  temp <- tempfile()
  dir.create(paste(main_dir, sub_dir, sep ="/"))
  download.file(url, temp)
  unzip(zipfile = temp, exdir = file.path(paste(main_dir, sub_dir, sep ="/")))
  unlink(c(temp))
  rm(temp)
} else {print("data available")}

## read files

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI_Baltimore <- NEI %>%
  select(fips, Emissions, year) %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  mutate(total.pm25 = sum(Emissions))

year <- unique(NEI_Baltimore$year)
total.B <- unique(NEI_Baltimore$total.pm25)

## simple bar-plot of sum of emissions PER YEAR to show decrease from 1999 to 2008

png(file = "plot2.png")

barplot(total.B, year,
        ylim = c(0, 4000),
        names.arg = c("1999", "2002", "2005", "2008"),
        main = "Total pm2.5 emissions 1999 - 2008 in Baltimore [to]",
        sub = "Emissions decreased by 1412 to (43%)",
        xlab = "Year",
        ylab = "Emissions [to]"
)
box()
dev.off()

rm(list = ls())