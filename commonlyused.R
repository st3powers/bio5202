
# load an already installed package
library(ggplot2)

# review the help files for any function
# use liberally !!  
?sum
?ggplot
?read.csv

# display current working directory (Where am I?)
getwd()

# Note that you can use setwd() to set working directory manually

# use  <-  to assign names to things
emptyvector<-c()

# using spaces can make code easier to read, without changing what the code does
emptyvector <- c() 

# make two vectors of numerical data manually
nums <- c(3,5,4,7,9,5,11)

# genarate a vector of evenly spaced values
nums_seq <- seq(from=0,by=10,to=1000)

# make a vector of character data manually
chars <- c("a","b","ab","1","01","A","other")

# show length of created objects
length(nums)
length(chars)

# identify which items are in contained in another object
chars %in% c("apples","organges", "other")

# identify items that contain the letter "a"
grep("a",chars,ignore.case=TRUE)
grep("a",chars,ignore.case=FALSE)

# convert character vector to a "factor" object
chars_factor <- as.factor(chars)

# generate a vector of 100 values with mean = 1 and standard deviation of 0.25
nums_rnorm <- rnorm(mean=1,sd=0.25,n=100)

# create a data frame (table object)
# note every column must have identical length
df <- data.frame(nums=c(3,5,4,7,9,5,11),
           chars=c("a","b","ab","1","01","c","other"),
           groups=c("one","one","two","one","two","two","one"))


# call an object
df
print(df)

# check the column names of a dataframe
names(df)

# use $ to call a single column of a dataframe
df$nums

# or, use [] and the column number 
df[,1] # first column only
df[,2] # second column only

# or call multiple columns
df[,c(1,2)]
df[,1:2]

# first row only
df[1,]
# second row only
df[2,]

# show the class (object type) of a saved object
# typical classes are dataframe, numeric vector, character vector, or factor
class(df)
class(nums)
class(chars)
class(chars_factor)

# list all active objects in current R session
ls()

# tidyverse coming soon...


# coming soon...

# read.csv()
# fread()
# write.csv()
# ggsave()
# png()


