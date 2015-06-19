#Q2---------------------------------------------------------------------------
#Reading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimoreData <- NEI[NEI$fips=="24510",]
q2 <- aggregate(baltimoreData$Emissions,by = list(baltimoreData$year), FUN = sum)
colnames(q2) <- c( "Year", "Emissions")
png(filename = "plot2.png")
plot(y = q2$Emissions, x = q2$Year, xlab = "Year", ylab = expression('PM'[2.5]), main = expression('Baltimore Total Emission of PM'[2.5] ) , ylim=c(0,3200), type ="b")
dev.off()
#-----------------------------------------------------------------------------
