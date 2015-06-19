
#Q3----------------------------------------------------------------------------
#Reading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)
baltimoreData <- NEI[NEI$fips=="24510",]

#summing the emission in baltimore based on the type and for each year. 
q3 <- aggregate(baltimoreData$Emissions,by = list(baltimoreData$year, baltimoreData$type), FUN = sum)
colnames(q3) <- c( "Year","Type", "Emissions")
png(filename = "plot3.png")
g <- ggplot(q3, aes(x = Year, y = Emissions))
g + geom_point( aes(color = Type), size = 4) + labs(x = "Year", y = expression('PM'[2.5]), title = "Baltimore Emission by Type")
dev.off()
#-----------------------------------------------------------------------------