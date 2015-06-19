#Q1---------------------------------------------------------------------------
#Reading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

q1 <- aggregate(NEI$Emissions,by = list(NEI$year), FUN = sum) #summing the emissions by year
colnames(q1) <- c("Year", "Emission")
#plot(x = q1$Year, y = q1$Emission, xlab = "Year", ylab = expression('PM'[2.5]), main = expression('Total Emission of PM'[2.5]), type="b")
png(filename = "plot1.png")
barplot(q1$Emission, names.arg = q1$Year,  xlab = "Year", ylab = expression('PM'[2.5]), main = expression('Total Emission of PM'[2.5]))
dev.off()
#----------------------------------------------------------------------------
