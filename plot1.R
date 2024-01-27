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

## group data by year

NEI_overall <- NEI %>% select(Emissions, year) %>% group_by(year)

## simple boxplot to show that Emissions decrease from 1999 to 2008

boxplot(Emissions ~ year, data = NEI_overall, outline = FALSE)


               
               