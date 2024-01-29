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
  select(fips, Emissions, type, year) %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarize(sum = sum(Emissions))

NEI_Baltimore$year <- as.factor(NEI_Baltimore$year)

png(file = "plot3.png")

Plot.Baltimore <- ggplot(NEI_Baltimore, aes(year, sum))

Plot.Baltimore  + geom_col() + facet_wrap(.~ type, scales ="free_y") + 
                theme_bw(base_family = "Arial", base_size = 10) +
                labs(x = "Year") +
                labs(y = expression("Total " * PM[2.5] * " [to]")) +
                labs(title = expression("Total " * PM[2.5] * " in Baltimore"))  

dev.off()

rm(list = ls())