## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$Emissions <- as.numeric(na.omit(NEI$Emissions))
NEI$year <- as.numeric(NEI$year)

PlotFileName="plot4.png"
PlotDirectory= "C:/Users/Massimo/Documents/GitHub/Coursera/DataScience/DataAnalysis/Week3/"

PlotFile <- paste(PlotDirectory, PlotFileName, sep="")
  


# ----------- Answer q.4
# find all types of emission related to coal
SCC.coal <- filter(SCC,grepl("Coal",Short.Name))
# find all emissions 
all.coal <- merge(SCC.coal,NEI,by="SCC")
# since I am going to use the log,  I jitter
# Emissions values that are 0 

# jitter function (this function adds a limited positive bias to the data)
jitter0 <- function(x) { if (x==0) {abs(jitter(x))} else x}

# record a new table with the jitter 
all.coal.no0 <- all.coal
# jitter emissions that are 0
all.coal.no0$Emissions <- sapply(all.coal$Emissions,jitter0)
# plot result
ggplot(all.coal.no0,aes(year,log(Emissions)))+
  geom_point() +
  geom_smooth(method="lm") +
  facet_grid(.~type,scales = 'free_x')+
  geom_point(aes(color=year))+
  theme_light()+
  ggtitle("Question 4: Log of emissions\nfrom coal combustion-related sources\nin the US  from 1999-2008")+
  theme(axis.ticks = element_blank(), 
        axis.text.x = element_blank())

# save the graph in the file
ggsave(PlotFile);
  
