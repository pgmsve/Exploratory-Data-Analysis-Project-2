# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(plyr)
library(ggplot2)

# read the rds data for PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")

# read the rds data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")

# open the graphic device
png(filename = 'plot3.png', width = 480, height = 480)

# total Emission for Baltimore (fips = 24510) indicated by its sources between 1999-2008
totalData <- ddply(NEI[NEI$fips == "24510",], c("year", "type"), function(df) sum(df$Emissions, na.rm = TRUE))

# plot final data to see which of the 4 sources have seen decreased emissions
p <- ggplot(data=totData, aes(x=year, y=V1, group=type, colour=type)) +
  geom_line() +
  xlab("Year") +
  ylab("PM2.5 (tons)") +
  ggtitle("Total PM2.5 Emissions (tons) Per Year by Source Type")

print(p)

# shut the graphic device
dev.off()

