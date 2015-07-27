# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# read the rds data for PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")

# read the rds data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")

# open the graphic device
png(filename = 'plot1.png', width = 480, height = 480, units = 'px')

# sum of all emissions group by individual years
aggrData <- with(NEI, aggregate(NEI[, 'Emissions'], by = list(year), sum, na.rm = TRUE))

# change col names for aggr data to more meaningful
names(aggrData) <- c('Year', 'TotalEmission')

# plot the aggregated data showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008
plot(aggrData, 
     type = "l", 
     xlab = "Year", 
     ylab = "Total PM2.5 Emissions From All US Sources Between 1999-2008", 
     col  = "blue", 
     xaxt = "n", 
     main = "Total Emissions (tons)")

# plot the x-axis containing the year
axis(1, at = as.integer(aggrData$Year), las = 1)

# shut the graphic device
dev.off()
