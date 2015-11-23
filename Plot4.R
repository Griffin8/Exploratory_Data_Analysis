
##############################################################################################################
#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
##############################################################################################################

#load data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#get SCC for coal combustion
coalcomb.scc <- subset(scc, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", 
                                             "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - 
                                             Coal"))
coalcomb.scc.other <- subset(scc, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

coal.scc <- union(coalcomb.scc$SCC, coalcomb.scc.other$SCC)

#get the subset of data for  coal combustion
nei.coal <- subset(nei, SCC %in% coal.scc)

#aggregate Emissions PM2.5 by year
agg = ddply(nei.coal, .(year, type), function(x) sum(x$Emissions))
colnames(agg)[3] <- "Emissions"

#save as png file
png(file="plot4.png", width=480, height=480)

#Plot
library(ggplot2)

g <-ggplot(data=agg, aes(x=year, y=Emissions, group=type, colour=type)) +
  geom_line() +
  geom_point()
print(g)

#close device
dev.off()