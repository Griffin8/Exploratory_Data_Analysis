

##############################################################################################################
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
##############################################################################################################

#load data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#aggregate Emissions PM2.5 by year
nei <- nei[nei$fips == "24510", ]
agg = ddply(nei, .(year, type), function(x) sum(x$Emissions))
colnames(agg)[3] <- "Emissions"

#save as png file
png(file="plot3.png", width=480, height=480)

#Plot
library(ggplot2)

g <-ggplot(data=agg, aes(x=year, y=Emissions, group=type, colour=type)) +
  geom_line() +
  geom_point() +
  labs(x="year", y=expression("Total PM[2.5] Emission (Tons)")) + 
  labs(title=expression("PM[2.5] Emissions, Baltimore City 1999-2008 by Source Type"))
print(g)

#close device
dev.off()