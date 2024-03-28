
# for loops
for (i in 1:10){
  print(i)
}

library(tidyverse)

################################
PATH1<-"https://raw.githubusercontent.com/waterfolk/waterfolkdata/main/samples.csv"
PATH2<-"https://raw.githubusercontent.com/waterfolk/waterfolkdata/main/measurements.csv"

samples<-read_csv(PATH1)
measurements<-read_csv(PATH2)

merged<-merge(samples,measurements, by="bottlecode")
#groups_unique<-unique(merged$system)
groups_unique<-unique(merged$analyte)

for(i in 1:length(groups_unique)){
  groupi<-groups_unique[i]
  datai<-merged %>% filter(analyte==groupi)
  gg_boxploti <- ggplot(datai,aes(x=system,y=result)) +
    geom_boxplot()+
    coord_flip()+theme_bw()
  namei<-paste(groupi,".png",sep="")
  ggsave(filename=namei,plot=gg_boxploti, width=5,height=5,units="in")
}

