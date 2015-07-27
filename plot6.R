# 6. Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

# read the rds data for PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")

# read the rds data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")

# open the graphic device
png(filename = 'plot6.png', width = 480, height = 480)

# subset "on-road" type and on Baltimore City (fips=24510) and LA County (fips == "06037")  
NEIonRoad <- NEI[(NEI$type=="ON-ROAD") & (NEI$fips %in% c("24510","06037")), ]

# filter out from all emissions on above criteria and calculate aggregate
aggrData <- aggregate(NEIonRoad$Emissions, list(Year = NEIonRoad$year, Location = as.factor(NEIonRoad$fips)), sum)

# calculate which city has has seen greater changes over time in motor vehicle emissions
totalData <- ddply(aggrData, "Location", transform, Growth = c(0,(exp(diff(log(x)))-1)*100))

# substitute the fips code back to respective cities to make sense in graph
totalData <- as.data.frame(sapply(totalData, gsub, pattern = "24510", replacement = "Baltimore"))
totalData <- as.data.frame(sapply(totalData, gsub, pattern = "06037", replacement = "Los Angeles"))

# plotting The growth on 2 cities with ggplot
p <- ggplot(totalData, aes(Year, Growth, fill = Location)) + 
 geom_bar(position = "dodge", stat="identity") + 
 labs(y="Variation (in %)") + 
 ggtitle(expression(atop(" Variation of emission of PM2.5", 
                    atop(italic("from motor vehicle sources"), ""))))

print(p)
# shut the graphic device
dev.off()
