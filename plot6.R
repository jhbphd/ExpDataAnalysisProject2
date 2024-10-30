# This code is designed to answer the following question:
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?
## No required plotting system, so this plot will use ggplot2
# MUSTS: 
# include the code for plot5.png 
# include the code for reading in the data so it can be reproduced

# Necessary Packages
library(dplyr)
library(ggplot2)
library(stringr)

# Read in Data
# Data from : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Consolidate and Manipulate the data
vehicle_scc <- SCC%>%
        filter(str_detect(SCC.Level.Two, "[Vv]ehicle"))
la_baltimore <- NEI %>% # this renames the data as la_baltimore
        inner_join(vehicle_scc, by = c("SCC" = "SCC"))%>% # this joins the NEI data with the vehcile_scc data on the SCC column
        filter(fips == "24510"| fips == "06037")%>%
        select(year, Emissions, fips) # selects for the year, Emissions, and fips columns

facet_cities <- as_labeller(c(`24510` = "Baltimore", `06037` = "Los Angeles"))

# Make the Plot
ggplot(la_baltimore, aes(factor(year), Emissions), fill = fips)+
        geom_bar(stat = "identity") +
        theme_bw() +
        facet_grid(.~fips, labeller = facet_cities) +
        labs(x = "Years",
             y = "Vehicle Emissions", 
             title = "Vehicle Emissions of Baltimore & LA by Year")

# Make the plot6.png
ggsave("plot6.png", width = 5, height = 5, units = "in") # saves as png