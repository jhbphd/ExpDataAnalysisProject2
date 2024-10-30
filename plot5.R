# This code is designed to answer the following question:
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
## No required plotting system, so this plot will use ggplot2
# MUSTS: 
# include the code for plot5.png 
# include the code for reading in the data so it can be reproduced

# necessary packages
library(dplyr)
library(ggplot2)
library(stringr)

# reading in the data
# Data from : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# consolidate and manipulate the data
scc_comb_coal <- SCC %>% # save the data as comb_coal
        # this filters for the emissions data that includes coal and comb (combustion) 
        filter(str_detect(SCC.Level.One, "[Cc]omb")) %>% # filtering for variants of comb
        filter(str_detect(SCC.Level.Three, "[Cc]oal")) %>% # filtering for variants of coal
        filter(str_detect(SCC.Level.Four, "[Cc]oal")) # filtering for variants of coal
comb_coal <- NEI %>% # this renames the data as comb_coal
        inner_join(scc_comb_coal, by = c("SCC" = "SCC"))%>% # this joins the NEI data with the scc_comb_coal data on the SCC column
        select(year, Emissions) # selects for the year and Emissions columns
vehicle_scc <- SCC%>%
        filter(str_detect(SCC.Level.Two, "[Vv]ehicle"))
vehicle_balt <- NEI%>%
        inner_join(vehicle_scc, by = c("SCC" = "SCC"))%>%
        filter(fips == "24510")%>%
        select(year, Emissions)

# making the plot

ggplot(vehicle_balt, aes(factor(year), Emissions))+
        geom_bar(stat="identity")+
        theme_bw()+
        labs(x="Years",
             y = "Total Emissions",
             title = "Vehicle Source Emission in Baltimore by Year")

# save as plot5.png 
ggsave("plot5.png", width = 5, height = 5, units = "in") # saves as png
