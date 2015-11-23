

###################################################################################
#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to 
#make a plot answering this question.
###################################################################################

#load data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#aggregate Emissions PM2.5 by year
nei <- nei[nei$fips == "24510", ]
agg = aggregate(Emissions ~ year, data=nei, sum)

#save as png file
png(file="plot2.png", width=480, height=480)

#Plot

barplot(agg$Emissions,names.arg = agg$year, main="PM2.5 Emissions in Baltimore City, Maryland", xlab = "Year", ylab = "PM2.5(tons)")

#close device
dev.off()