
# for loops
for (i in 1:10){
  print(i)
}

################################
PATH1<-"https://raw.githubusercontent.com/waterfolk/waterfolkdata/main/samples.csv"
PATH2<-"https://raw.githubusercontent.com/waterfolk/waterfolkdata/main/measurements.csv"

samples<-read_csv(PATH1)
measurements<-read_csv(PATH2)
