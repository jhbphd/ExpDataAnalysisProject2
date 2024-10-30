# This code is designed to answer the following question:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? Which have seen increases 
# in emissions from 1999–2008? Use the ggplot2 plotting system to
# make a plot answer this question.
## The plotting system required is the ggplot2 plotting system.
# MUSTS: 
# include the code for plot3.png 
# include the code for reading in the data so it can be reproduced

# required packages
# Data from : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds") # reads the data and saves as NEI

balt_type <- NEI %>% # renames the datat balt_type
        select(year, type, Emissions, fips) %>% # selects the year, type, emissions, and fips variables for use
        filter(fips == "24510") # filters to keep the baltimore data
ggplot(balt_type, aes(factor(year), Emissions),fill = type)+
        geom_bar(stat = "identity")+ #makes it a bar graph
        theme_bw()+ # black and white theme
        facet_wrap(.~type, nrow = 2, ncol =2)+ # splits into multiples
        labs(title = "Baltimore Emissions by Type and Year", # labels plots and axis
             x = "Year",
             y = "Emissions")
ggsave("plot3.png", width = 5, height = 5, units = "in") # saves as png
