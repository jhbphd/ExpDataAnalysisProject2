# This code is designed to answer the following question:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
# a plot answering this question.
## The plotting system required is the BASE plotting system.
# MUSTS: 
# include the code for plot2.png 
# include the code for reading in the data so it can be reproduced

## Load necessary packages
library(dplyr) # loads the dply package from the library

## Read in data
# Data from : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
NEI <- readRDS("summarySCC_PM25.rds")  

# Manipulate and Consolidate the data
BaltPM <- NEI %>% # saves new data as BaltPM
        select(fips, Emissions, year) %>%  # selects columns fips, Emissions, and year
        filter(fips == '24510') %>% # filters for fips data with the 24510 code
        group_by(year) %>% # groups data by year
        mutate(year = factor(year)) %>%
        summarize(total_pm = sum(Emissions)) # creates new variable sum of emissions grouped by year
# Create the png
png(filename = "plot2.png", width = 5, height = 5, units = "in", res = 144)
# Make the plot
with(
        BaltPM,
        barplot(
                total_pm,
                names = year,
                xlab = "Years",
                ylab = "Emissions",
                main = "Total Emissions in Baltimore from 1999-2008"
        )
)

dev.off()