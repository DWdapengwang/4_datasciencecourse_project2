
#Q4------------------------------------------------------------------------------
#Reading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

#finding the rows containing the word coal, and getting the SCC number
#Then merging to the NEI dataset. 
coalSCCNumber2 <- SCC[grep(pattern = "Coal", x = SCC$EI.Sector), ]
q4merge <- merge(x = NEI, y = coalSCCNumber2, by = "SCC")
#Summing the emission by year. 
q4merge2 <- aggregate(q4merge$Emissions, by = list(q4merge$year), FUN = sum)
colnames(q4merge2) <- c( "Year", "Emissions")
png(filename = "plot4.png")
plot(y = q4merge2$Emissions, x = q4merge2$Year, xlab = "Year", ylab = expression('PM'[2.5]), main = "Total emissions from coal combustion-related sources\n in the United States")
dev.off()
#--------------------------------------------------------------------------------
