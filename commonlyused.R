
# load an already installed package
library(ggplot2)

# review the help files for any function 
?sum
?ggplot
?read.csv

# display current directory (Where am I?)
getwd()

# use setwd() to set working directory manually

# use <- to assign names to things
emptyvector<-c()

# make a vector of numerical data manually
nums<-c(3,5,4,7,9,5,11)

# genarate a vector of evenly spaced values
nums_seq<-seq(from=0,by=10,to=1000)

# make a vector of character data manually
chars<-c("a","b","ab","1","01","c","other")

# show length of created objects
length(nums)
length(chars)

# convert character vector to a "factor" object
chars_factor<-as.factor(c("a","b","ab","1","01","c","other"))

# generate a vector of 100 values with mean = 1 and standard deviation of 0.25
nums_rnorm<-rnorm(mean=1,sd=0.25,n=100)

# create a data frame (table object)
# note every column must have identical length
df<-data.frame(nums=c(3,5,4,7,9,5,11),
           chars=c("a","b","ab","1","01","c","other"))


# using spaces can sometimes make code easier to read
df1 <- df # same thing as df1<-df

# call an object
df
print(df)

# show the class (object type) of a saved object
class(nums)
class(chars)
class(chars_factor)

# list all active objects in current session
ls()


# read.csv()
# write.csv()

