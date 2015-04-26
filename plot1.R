## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$Emissions <- as.numeric(na.omit(NEI$Emissions))
NEI$year <- as.numeric(NEI$year)

PlotFileName="plot1.png"
PlotDirectory= "C:/Users/Massimo/Documents/GitHub/Coursera/DataScience/DataAnalysis/Week3/"

PlotFile <- paste(PlotDirectory, PlotFileName, sep="")
  
plot.project2 <- function (data, PlotFile) {
  ## split the data in the reevant subsets
  data.1999 <- subset(data,year==1999) 
  data.2002 <- subset(data,year==2002)
  data.2005 <- subset(data,year==2005)
  data.2008 <- subset(data,year==2008)
  # compute the relevant means
  data.1999.m <- mean(data.1999$Emissions)
  data.2002.m <- mean(data.2002$Emissions)
  data.2005.m <- mean(data.2005$Emissions)
  data.2008.m <- mean(data.2008$Emissions)
  # collect them
  data.means <- c(data.1999.m, data.2002.m, data.2005.m, data.2008.m)
  # get years
  data.years <- as.factor(unique(data$year))
  # compute the linear model
  data.model <- lm(data.years ~ data.means)
  # open file device
  png(filename= PlotFile) 
  # 
  par(mfrow=c(2,1),mai=c(.6,1.2,.1,.1))
  # plot the relation between dates and means
  plot(data.years,data.means,ylab="average PM2.5 per year")
  # add linear model
  abline(data.model,col="blue")
  # add boxplot 
  boxplot(Emissions ~ year,data, 
          outline = FALSE,
          ylab="PM2.5 level distribution")
  # close device
  dev.off() 
}  

# call the plot function with the overall data
plot.project2(NEI,PlotFile)
