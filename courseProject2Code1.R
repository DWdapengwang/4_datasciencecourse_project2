#Explortaory data analysis, course project 2######################################

#Reading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Q1---------------------------------------------------------------------------
#Reading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

q1 <- aggregate(NEI$Emissions,by = list(NEI$year), FUN = sum) #summing the emissions by year
colnames(q1) <- c("Year", "Emission")
#plot(x = q1$Year, y = q1$Emission, xlab = "Year", ylab = expression('PM'[2.5]), main = expression('Total Emission of PM'[2.5]), type="b")
png(filename = "plot1.R")
barplot(q1$Emission, names.arg = q1$Year,  xlab = "Year", ylab = expression('PM'[2.5]), main = expression('Total Emission of PM'[2.5]))
dev.off()
#----------------------------------------------------------------------------


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
plot(y = q4merge2$Emissions, x = q4merge2$Year, xlab = "Year", ylab = expression('PM'[2.5]), main = "Total emissions from coal combustion-related sources\n in the United States")
#--------------------------------------------------------------------------------


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
plot(x = q5sum$Year, y = q5sum$Emission, xlab = "Year", ylab= expression('PM'[2.5]),  title = "Total Emission of\nMotor Vehichle Sources in Baltimore City")
dev.off()
#-----------------------------------------------------------------------------


#q6----------------------------------------------------------------------------
#Reading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

#finding the data related to LA
LAData <- NEI[NEI$fips=="06037",]
baltimoreData <- NEI[NEI$fips=="24510",]

#finding the sum of motor vehicle source for Baltimore 
motorSCCNumber <- SCC[grep(pattern = "Mobile - On-Road", x = SCC$EI.Sector) , ]
q5merge <- merge(x = baltimoreData, y = motorSCCNumber, by="SCC")
q5sum <- aggregate(q5merge$Emissions, by = list(q5merge$year), FUN = sum)
colnames(q5sum) <- c("Year", "Emission")

#finding the sum of motor vehichle for Los Angeles county
q6merge <- merge(x = LAData, y = motorSCCNumber, by="SCC")
q6sum <- aggregate(q6merge$Emissions, by= list(q6merge$year), FUN = sum)
colnames(q6sum) <- c("Year", "Emission")

#combinding the two city's data and plotting
q6sum$City = "LA"
q5sum$City = "Baltimore"
q6combined <- rbind(q6sum, q5sum)
png(filename = "plot6.png")
g6 <- ggplot(q6combined, aes(x = Year, y = Emission))
g6 + geom_point(aes(color = City), size = 4) + labs(x = "Year", y = expression('PM'[2.5]), title = "Total Emission of Motor Vehichle Sources,\n Baltimore City and Los Angeles County")
dev.off()

