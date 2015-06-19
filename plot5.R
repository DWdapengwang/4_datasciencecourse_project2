#Q5----------------------------------------------------------------------------
#Reading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)
baltimoreData <- NEI[NEI$fips=="24510",]

#finding the sum of motor vehicle source for Baltimore
motorSCCNumber <- SCC[grep(pattern = "Mobile - On-Road", x = SCC$EI.Sector) , ]
q5merge <- merge(x = baltimoreData, y = motorSCCNumber, by="SCC")
q5sum <- aggregate(q5merge$Emissions, by = list(q5merge$year), FUN = sum)
colnames(q5sum) <- c("Year", "Emission")

png(filename = "plot5.png")
plot(x = q5sum$Year, y = q5sum$Emission, xlab = "Year", ylab= expression('PM'[2.5]), main = "Total Emission of\nMotor Vehichle Sources in Baltimore City")
dev.off()
#-----------------------------------------------------------------------------