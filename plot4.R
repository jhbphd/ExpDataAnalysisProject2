# This code is designed to answer the following question:
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?
## No required plotting system, so this plot will use ggplot2
# MUSTS: 
# include the code for plot4.png 
# include the code for reading in the data so it can be reproduced

# required libraries
library(dplyr)
library(ggplot2)
library(stringr)

# Read in the data
# Data from : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Consolidate and manipulate the data
scc_comb_coal <- SCC %>% # save the data as comb_coal
        # this filters for the emissions data that includes coal and comb (combustion) 
        filter(str_detect(SCC.Level.One, "[Cc]omb")) %>% # filtering for variants of comb
        filter(str_detect(SCC.Level.Three, "[Cc]oal")) %>% # filtering for variants of coal
        filter(str_detect(SCC.Level.Four, "[Cc]oal")) # filtering for variants of coal
comb_coal <- NEI %>% # this renames the data as comb_coal
        inner_join(scc_comb_coal, by = c("SCC" = "SCC"))%>% # this joins the NEI data with the scc_comb_coal data on the SCC column
        select(year, Emissions) # selects for the year and Emissions columns


# make the plot

ggplot(comb_coal, aes(factor(year), Emissions))+ # makes the plot using year (as a factor) and emissions
        geom_bar(stat = "identity") + # makes it a bar graph
        theme_bw() + # black and white
        labs(x = "Years", # labels
             y = "Total Emissions",
             title = "Coal Combustion Source emissions in US by year")
# save as a png
ggsave("plot4.png", width = 5, height = 5, units = "in") 