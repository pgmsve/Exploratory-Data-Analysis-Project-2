# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

library(plyr)

# read the rds data for PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")

# read the rds data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")

# open the graphic device
png(filename = 'plot2.png', width = 480, height = 480, units = 'px')

# aggregate to see if total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008
aggrDataPerYear <- ddply(NEI[NEI$fips == "24510",], c("year"), function(df) sum(df$Emissions, na.rm = TRUE))

# plot the final aggregate data for Baltimore city from 1999-2008 
plot(aggrDataPerYear$year, 
     aggrDataPerYear$V1, 
     type = "l", 
     xlab = "Year", 
     ylab = "PM2.5 Emissions (tons)", 
     main = "PM2.5 Generated between years 1999-2008 in Baltimore City, MD")


# shut the graphic device
dev.off()
