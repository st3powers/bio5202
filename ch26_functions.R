library(tidyverse)
library(nycflights13)

# What does the code do?

df <- tibble(
  a = rnorm(5),
  b = rnorm(5),
  c = rnorm(5),
  d = rnorm(5),
)

df |> mutate(
  a = (a - min(a, na.rm = TRUE)) / 
    (max(a, na.rm = TRUE) - min(a, na.rm = TRUE)),
  b = (b - min(b, na.rm = TRUE)) / 
    (max(b, na.rm = TRUE) - min(a, na.rm = TRUE)),
  c = (c - min(c, na.rm = TRUE)) / 
    (max(c, na.rm = TRUE) - min(c, na.rm = TRUE)),
  d = (d - min(d, na.rm = TRUE)) / 
    (max(d, na.rm = TRUE) - min(d, na.rm = TRUE)),
)
#> # A tibble: 5 × 4
#>       a     b     c     d
#>   <dbl> <dbl> <dbl> <dbl>
#> 1 0.339  2.59 0.291 0    
#> 2 0.880  0    0.611 0.557
#> 3 0      1.37 1     0.752
#> 4 0.795  1.37 0     1    
#> 5 1      1.34 0.580 0.394


myfunc<-function(myvector){
  numvectorTF<-is.numeric(myvector)
  if(numvectorTF == TRUE){
  meancalc<-mean(myvector)
  sumcalc<-sum(myvector)
  meanpart<-paste("mean = ",meancalc)
  sumpart<-paste("sum = ",sumcalc)
#  response<-c(meanpart,sumpart)
  response<-paste(meanpart,", ",sumpart,sep="")
  }
  if(numvectorTF==FALSE){
    response<-"not a numeric vector"
  }
  response
}

x<-c(4,6,5)
myfunc(myvector=x)

vectorlist<-list(x=c(4,6,5),y=c(7,5,9,8),z=c("why","did the chicken cross the road"))

lapply(vectorlist,myfunc)


x<-c(4,3,6)
y<-c(5,4,7,6)

myfunc2<-function(myvector1,myvector2){
  numvectorTF<-is.numeric(c(myvector1,myvector2))
  if(numvectorTF == TRUE){
    meancalc<-mean(c(myvector1,myvector2))
    sumcalc<-sum(c(myvector1,myvector2))
    meanpart<-paste("mean = ",meancalc)
    sumpart<-paste("sum = ",sumcalc)
    #  response<-c(meanpart,sumpart)
    response<-paste(meanpart,", ",sumpart,sep="")
  }
  if(numvectorTF==FALSE){
    response<-"not a numeric vector"
  }
  response
}

myfunc2(myvector1=x,myvector2=y)




