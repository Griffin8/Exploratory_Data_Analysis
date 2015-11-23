

###################################################################################
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
#for each of the years 1999, 2002, 2005, and 2008.
###################################################################################

#load data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#aggregate Emissions PM2.5 by year
agg <- aggregate(Emissions ~ year, data=nei, sum)

#save as png file
png(file="plot1.png", width=480, height=480)

#Plot

barplot(agg$Emissions/10^6,names.arg = agg$year, main="PM2.5 Emissions in US", xlab = "Year", ylab = "PM2.5(/10^6 tons)")

#close device
dev.off()