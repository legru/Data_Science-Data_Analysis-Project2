## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$Emissions <- as.numeric(na.omit(NEI$Emissions))
NEI$year <- as.numeric(NEI$year)

PlotFileName="plot5.png"
PlotDirectory= "C:/Users/Massimo/Documents/GitHub/Coursera/DataScience/DataAnalysis/Week3/"

PlotFile <- paste(PlotDirectory, PlotFileName, sep="")
  
# ----------- Answer q.5
# get all motor related sources of pollution
SCC.motor <- filter(SCC,grepl("Motor",Short.Name,ignore.case = TRUE))
# get emission data for these sources
all.motor <- merge(SCC.motor,NEI,by="SCC")
# extract data about Baltimore
all.motor.Baltirmore <- filter(all.motor,fips == "24510")
# plot emission per year (removing the outliers)
ggplot(all.motor.Baltirmore,aes(year,Emissions))+
  geom_point() +
  geom_smooth(method="lm") +
  geom_point(aes(color=year))+
  theme_light()+
  coord_cartesian(ylim=c(-0.10,2.5))+
  theme(axis.ticks = element_blank(), 
        axis.text.x = element_blank())+
  ggtitle("Question 5: log of emissions from motor vehicle sources\n in Baltimore City from 1999-2008 \n outliers removed")

# save the graph in the file
ggsave(PlotFile);

