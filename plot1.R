# This code is designed to answer the following question:
# Have total emissions from PM2.5 decreased in the United States from
# 1999 to 2008? Using the base plotting system, make a plot showing
# the total PM2.5 emission from all sources for each of the years 1999,
# 2002, 2005, and 2008.
## The plotting system required is the BASE plotting system.
# MUSTS: 
# include the code for plot1.png 
# include the code for reading in the data so it can be reproduced

# Data from : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#install.packages("tidyr")
#library("tidyr")
#install.packages("dplyr")
#library("dplyr")

## Reading in the data
# Data from : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

NEI <- readRDS("summarySCC_PM25.rds") 

# saves data as PMxYear - selects for Emissions and year, setting year as a 
        # factor and creating total_pm, a sum of emissions by year
PMxYear <- NEI %>%
        select(Emissions, year)%>%
        group_by(year)%>%
        mutate(year = factor(year))%>%
        summarize(total_pm = sum(Emissions))

# creating plot1.png
png(filename = "plot1.png", width = 5, height = 5, units = "in", res = 144) 

# create bar plot with base R
with(
        PMxYear,
        barplot(
                total_pm,
                names = year,
                xlab = "Years",
                ylab = "Emissions",
                main = "Total Emissions from 1999 to 2008"
        )
)

dev.off()