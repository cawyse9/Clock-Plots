library(plotly)
library(lubridate)
library(ggplot2)
library(celestial)
library(tidyverse)
library(geomtextpath)
library(psych)


###########
#get patient times from excel
#P1wake<- scan()
#P1sleep<-scan()
#P2wake<-scan()
#P2sleep<-scan()

###########

#define colors
COL2<-'#541352FF' #viridis
COL1<-'#ffcf20FF'
COL1<-'#ff7f0e' #tableau orange
  
#input is vector of bedtimes and waketimes
clock<-as.data.frame(cbind(bedtimes,waketimes))
clock<-gather(clock)

#get mean times
mean_bed <- circadian.mean(bedtimes)
mean_wake <-mean(waketimes)
mean_bed <- format(as.POSIXct(hms(hours=mean_bed)),"%H:%M")
mean_wake <-format(as.POSIXct(hms(hours=mean_wake)),"%H:%M")

ggplot(clock, aes(x =x, y=1)) + 
  #geom_polygon(fill = NA, col = 1) +
  geom_hline(yintercept = 1.2, colour = "grey90", lwd= 1) +
  geom_vline(xintercept = bedtimes, color = COL2, linetype = "solid", alpha=1, linewidth=.30)+
  geom_vline(xintercept = waketimes, color = COL1, linetype = "solid", alpha=1, linewidth=.30) +
  geom_vline(xintercept = circadian.mean(bedtimes), color = COL2, linetype = "solid", alpha=1, linewidth=1.5)+
  geom_vline(xintercept = mean(waketimes), color =  COL1, linetype = "solid", alpha=1, linewidth=1.5) +
  geom_point(data=sleep,aes(x=x,y=1.2),size =3, color = COL2, fill="white",shape=21, alpha = 1) +
  geom_point(data=wake,aes(x=x,y=1.2),size = 3, color = COL1, fill="white",shape=21, alpha = 1) +
  theme_minimal() + 
  coord_polar(start=0, clip='off') +
  
  scale_x_continuous(breaks = c(1:24), limits = c(0,24)) +
  
  ylim(0, 1.2)+ 

  theme(
  legend.position = "none",
  plot.margin = unit(c(3,3,1,1), "lines"),
  panel.grid.major = element_line(size = 0.1, linetype = 'solid',colour = "grey95"), 
  panel.grid.minor = element_line(size = 0.1, linetype = 'solid',colour = "grey95"),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.y = element_blank(),
  panel.background = element_blank(),
  panel.border = element_blank(),
  panel.ontop =FALSE,
  
  axis.text.x = element_text(face = "bold", size=10) )+
   annotate("text", x = c(max(bedtimes)-3.5, max(waketimes)+2.5), y = c(0.7,0.7), 
            label = c(
              paste0("Sleep Times\n(average = ",mean_bed,")"),
              paste0("Wake Times\n(average = ", mean_wake,")")),
              fontface =2, 
              size=3,
              col=c(COL2,COL1), 
              vjust = "center", hjust = "middle")

ggsave("times.pdf", height=5, width = 5, units= "in", dpi = 600)





