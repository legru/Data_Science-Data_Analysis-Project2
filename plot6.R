## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$Emissions <- as.numeric(na.omit(NEI$Emissions))
NEI$year <- as.numeric(NEI$year)


# ----------- Answer q.6
# get all motor related sources of pollution
SCC.motor <- filter(SCC,grepl("Motor",Short.Name,ignore.case = TRUE))
# get emission data for these sources
all.motor <- merge(SCC.motor,NEI,by="SCC")
# extract data about Baltimore and LA
all.motor.B_LA <- filter(all.motor,fips %in% c("24510","06037"))
# plot the data
qplot(year,Emissions,
      data=all.motor.B_LA,
      color= fips,
      geom=c("point",  "smooth"),	 
      method="lm",
      main("Question 6: Compare emissions from motor vehicle sources in Baltimore City with same sources in Los Angeles County")
)


# File managment
PlotFileName="plot6.png"
PlotDirectory= "C:/Users/Massimo/Documents/GitHub/Coursera/DataScience/DataAnalysis/Week3/"
PlotFile <- paste(PlotDirectory, PlotFileName, sep="")
# save the graph in the file
ggsave(PlotFile);