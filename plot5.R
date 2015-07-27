# 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

library(ggplot2)

# read the rds data for PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")

# read the rds data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")

# open the graphic device
png(filename = 'plot5.png', width = 480, height = 480)

# subset "on-road" type and on Baltimore City (fips=24510)  
NEIonRoad <- NEI[(NEI$type=="ON-ROAD") & (NEI$fips=="24510"), ]

# filter out from all emissions on above criteria and calculate aggregate
aggrData <- aggregate(NEIonRoad$Emissions, list(Year=NEIonRoad$year), sum)

# reduce
# aggrData$x <- aggrData$x/1000

# plotting the details to answer how emissions changed from motor vecicle sources 
p <- ggplot(aggrData) + 
   geom_line(aes(y = x, x = Year)) + 
   labs(y="Amount of PM2.5 emitted (tons)") + 
   ggtitle(expression(atop("Total PM2.5 emission from motor vehicle sources", 
                          atop(italic("Baltimore City, Maryland"), ""))))

 print(p)
# shut the graphic device
dev.off()

