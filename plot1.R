## Peer-graded Assignment: Exploratory Data Analysis Course Project 2
## Plot1

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

NEI_overall <- NEI %>%
        select(Emissions, year) %>%
        group_by(year) %>%
        mutate(total.pm25 = sum(Emissions))

year <- unique(NEI_overall$year)
total <- unique(NEI_overall$total.pm25)

## simple bar-plot of sum of emissions PER YEAR to show decrease from 1999 to 2008

png(file = "plot1.png")

barplot(total/10^6, year, 
        ylim = c(0, 10),
        names.arg = c("1999", "2002", "2005", "2008"),
        main = "Total pm2.5 emissions 1999 - 2008 [mto]",
        sub = "Emissions decreased by 3.9 mto (53%)",
        xlab = "Year",
        ylab = "Emissions [mto]"
)
box()
dev.off()

rm(list = ls())