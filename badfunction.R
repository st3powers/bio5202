

# function to return the mean and sum of a number vector

myfunc <- function(myvector)(
  numvectorTF <- is.numeric(myvector)
  if(numvectorFT == TRUE){
    meancalc <- mean(myvector)
    sumcalc <- sum(myvector)
    meanpart <- paste("mean = ", meancalc)
    sumpart <- paste("sum = ", sumcal)
    #  response<-c(meanpart,sumpart)
    response <- paste(mean,", ", sumpart, sep="")
  }
  if(numvectorTF = F){
    response <- "not a numeric vector"
  }
)


x<-c(4,6,5)
myfunc(myvector=x)


