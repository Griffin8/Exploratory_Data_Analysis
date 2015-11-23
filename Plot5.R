

##############################################################################################################
#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
##############################################################################################################

#load data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

vehicles <- grepl("vehicle", scc$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- scc[vehicles,]$SCC
vehiclesNEI <- nei[nei$SCC %in% vehiclesSCC,]

#subset the emissions from motor vehicles and NEI for Baltimore, MD.

nei.vehicle <- vehiclesNEI[vehiclesNEI$fips=="24510",]

#aggregate Emissions PM2.5 by year
agg = ddply(nei.vehicle, .(year, type), function(x) sum(x$Emissions))
colnames(agg)[3] <- "Emissions"

#save as png file
png(file="plot5.png", width=480, height=480)

#Plot
library(ggplot2)

g <-ggplot(data=agg, aes(x=year, y=Emissions, group=type, colour=type)) +
  geom_line() +
  geom_point() +
  labs(x="year", y=expression("Total PM[2.5] Emission (Tons)")) + 
  labs(title=expression("PM[2.5] Emissions from motor vehicle from 1999-2008 in Baltimore City"))
print(g)

#close device
dev.off()