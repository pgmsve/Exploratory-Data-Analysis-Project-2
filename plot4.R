# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

library(ggplot2)

# read the rds data for PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")

# read the rds data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")

# open the graphic device
png(filename = 'plot4.png', width = 480, height = 480)

# filter out all Coal related source names from SCC Table
coalSources <- SCC[grep("^Coal ", SCC$Short.Name, ignore.case=F),"SCC"]

# filter out all related emission sources for all the above Coal Sources
aggrData <- ddply(NEI[NEI$SCC %in% coalSources,], c("year"), function(df) sum(df$Emissions, na.rm = TRUE))

# change column names for this aggregated data to more meaningful
names(aggrData) <- c('Year', 'Emissions')

# plot final data to plot Total Emissions Trend from Coal Combustion-related sources
p <- ggplot(aggrData, aes(x = Year,y = Emissions))+
       geom_line()+
       xlab('Year')+
       ylab('Total PM2.5 Emissions (tons)')+
       ggtitle('Total Emissions Trend from Coal Combustion-related sources')
print(p)


# shut the graphic device
dev.off()
