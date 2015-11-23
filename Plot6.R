

##############################################################################################################
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
#Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
##############################################################################################################

#load data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

vehicles <- grepl("vehicle", scc$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- scc[vehicles,]$SCC
vehiclesNEI <- nei[nei$SCC %in% vehiclesSCC,]

#subset the emissions from motor vehicles and NEI for Baltimore, MD and Los Angeles

nei.vehicle <- vehiclesNEI[vehiclesNEI$fips %in% c("24510","06037"),]

#replace IDs in y_data with active labels
index <- c("24510", "06037")
values <- c("Baltimore", "Los Angeles")
nei.vehicle$City <- values[match(nei.vehicle$fips, index)]


#aggregate Emissions PM2.5 by year
agg = ddply(nei.vehicle, .(year, City), function(x) sum(x$Emissions))
colnames(agg)[3] <- "Emissions"

#save as png file
png(file="plot6.png", width=480, height=480)

#Plot
library(ggplot2)

g <-ggplot(data=agg, aes(x=year, y=Emissions, group=City, colour=City)) +
  geom_line() +
  geom_point() +
  labs(x="year", y=expression("Total PM[2.5] Emission (Tons)")) + 
  labs(title=expression("PM[2.5] Emissions from motor vehicle from 1999-2008 in Baltimore City and Los Angeles"))
print(g)

#close device
dev.off()