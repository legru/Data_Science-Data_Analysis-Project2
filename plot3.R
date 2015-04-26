## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$Emissions <- as.numeric(na.omit(NEI$Emissions))
NEI$year <- as.numeric(NEI$year)

PlotFileName="plot3.png"
PlotDirectory= "C:/Users/Massimo/Documents/GitHub/Coursera/DataScience/DataAnalysis/Week3/"

PlotFile <- paste(PlotDirectory, PlotFileName, sep="")
  
# get data exclusively about Balteimore
NEI.Baltimore <- subset(NEI, fips == "24510")

# ------------------------ answer q.3

# plot
ggplot(NEI.Baltimmore,aes(year,Emissions))+
  geom_point() + 
  geom_smooth(method="lm") + 
  facet_grid(.~type)+
  geom_point(aes(color=year))+
  theme_light()+
  coord_cartesian(ylim=c(-30,500))+
  theme(axis.ticks = element_blank(), 
        axis.text.x = element_blank())+
  ggtitle("Question 3:  Decreases in emissions from 1999-2008\nfor Baltimore City by emission type")

# save the graph in the file
ggsave(PlotFile);

