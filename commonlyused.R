
# load an already installed package
library(ggplot2)
library(tidyverse)
library(data.table)
library(ggthemes)
library(readxl)

# review the help files for any function
# use liberally !!  
?sum
?ggplot
?read.csv

# display current working directory (Where am I?)
getwd()

# Note that you can use setwd() to set working directory manually

# clear everything - remove all loaded objects from the current session/environment
rm(list = ls())

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

# view the first 6 rows of a dataframe (or tibble)
head(df)
#view the last 2 rows of a dataframe (or tibble)
tail(df,2)

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
# first two rows only (example of many paths to the same goal)
df[1:2,]
df[c(1,2),]
head(df,2)

# How many rows in a dataframe (or tibble)?
nrow(df)
# How many columns in a dataframe (or tibble)?
ncol(df)

# show the class (object type) of a saved object
# typical classes are dataframe, tibble (tidyverse), numeric vector, character vector, factor
class(df)
class(nums)
class(chars)
class(chars_factor)

# list all active objects in current R session
ls()


# A grand list of all the R functions (base R, no packages)
ls("package:base")
# A list of all the R functions of the package dplyr
ls("package:dplyr")

# A grand list of all packages on CRAN 
# https://cran.r-project.org/web/packages/available_packages_by_name.html

# reading in data

# if the files are located in your working directory (multiple ways)
students_classic<-read.csv("students.csv")
students_tidy_csv <- read_csv("students.csv") 
students_tidy_tsv <- read_tsv("students_tsv.txt")
students_tidy_txt <- read_csv("students.txt")
students_xlsx <- read_excel("students.xlsx") 
students_fread <- fread("students.csv") 
# note that fread function is much faster for reading large files (tens of MB or larger)

# if the files are located in a subfolder of your working directory (multiple ways)
students_classic<-read.csv("data/students2.csv")
students_tidy_csv <- read_csv("data/students2.csv") 
students_tidy_tsv <- read_tsv("data/students2_tsv.txt")
students_tidy_txt <- read_csv("data/students2.txt")
students_xlsx <- read_excel("data/students.xlsx") 
students_fread <- fread("data/students2.csv") 

# To directly load data files from on a web location (multiple ways)
students_tidy <- read_csv("https://pos.it/r4ds-students-csv")
students_github_tidy <- read_csv('https://raw.githubusercontent.com/st3powers/bio5202/main/students.csv')

url<-"https://raw.githubusercontent.com/st3powers/bio5202/main/students.csv"
students_fread<-fread(url, header =  TRUE, sep = ',' , stringsAsFactors=FALSE,
               colClasses="character")

# to batch read multiple files from the working directory (root), useful when you have many files
filenames<-list.files() # list all file names
filenames_csvtxt<-filenames[grep(".csv|.txt", filenames)] # restrict to filenames ending in .csv or .txt
data_list<-lapply(filenames_csvtxt,FUN="fread") # read each txt or csv file iteratively into a list object
names(data_list)<-filenames_csvtxt # add names to each item in the list
data_list$students.csv 

# to batch read multiple files from a subfolder, useful when you have many files
filenames<-list.files("./data") # list all file names located in the 'data' subfolder
filenames_csvtxt<-filenames[grep(".csv|.txt", filenames)] # restrict to filenames ending in .csv or .txt
filenames_csvtxt_longpath<-paste("./data/",filenames_csvtxt,sep="") # create long form of file paths, with subfolder 'data'
data_list<-lapply(filenames_csvtxt_longpath,FUN="fread") # read each txt or csv file iteratively into a list object
names(data_list)<-filenames_csvtxt # add names to each item in the list
data_list$students2.csv 

library(janitor)

poorly_named_df <- data.frame(Column.a=c(1,6,4,9),Column_B=c(7,3,9,3),columnC=c(8,5,3,8))
clean_names(poorly_named_df)


# exporting data 
write.csv(students_tidy_csv,"data_export.csv")

# exporting plots using ggsave(), png(), or tiff()
plot_default<-ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()+
  theme_bw()

plot_colorfriendly<-ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()+
  scale_color_colorblind()+
  theme_bw()

ggsave(filename="plot_colorfriendly.png",plot_colorfriendly,
       width=5,height=4,units="in")
ggsave(filename="plot_colorfriendly.tiff",plot_colorfriendly,
       width=5,height=4,units="in")

png(filename="plot_colorfriendly.png", width=5,height=4,units="in",res=300)
plot_colorfriendly
dev.off()

tiff(filename="plot_colorfriendly.tiff", width=5,height=4,units="in",res=300)
plot_colorfriendly
dev.off()

# learn more about ggplot shape and line type options
vignette("ggplot2-specs")
#https://cran.r-project.org/web/packages/ggplot2/vignettes/ggplot2-specs.html
#https://ggplot2.tidyverse.org/reference/

# check out geom_errorbar, geom_pointrange, geom_col


df <- data.frame(trt = c("a", "b", "c"), outcome = c(2.3, 1.9, 3.2))
ggplot(df, aes(trt, outcome)) +
  geom_col()

mytable1<-tribble(
  ~one,~two,~three,
  "a",1,9,
  "a",2,5,
  "b",3,5,
  "b",8,2,
  "b",2,7,
  "c",3,3
)

mytable2<-tribble(
  ~one,~four,
  "a","animals",
  "b","beatles",
  "c","cranberries"
)

merge(mytable1,mytable2,by="one")

# point and range plot using stat_summary()

ggplot(diamonds) + 
  stat_summary(
    aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

# 95 % confidence interval plot

ggplot(diamonds) + 
  stat_summary(
    aes(x = cut, y = depth),
    fun = median,
    fun.min = function(y) quantile(y, 0.025),  # Lower bound of 95% CI
    fun.max = function(y) quantile(y, 0.975),  # Upper bound of 95% CI
    geom = "pointrange"
  )


######################################################

# statistical support 

# differences between groups
# are there any differences 
aov1 <- aov(Petal.Length~Species,data=iris)
summary(aov1)
# or
aov(Petal.Length~Species,data=iris) %>% 
  summary()

TukeyHSD(aov1)
# or
aov(Petal.Length~Species,data=iris) %>% 
  summary() %>% TukeyHSD()

# Is there a significant linear relationship?
lm1 <- lm(Sepal.Length~Petal.Length,data=iris)
summary(lm1)

# diagnostic plots of linear regression models
plot(lm1) # if you want to toggle through several different diagnostic plots
plot(lm1, which=1) # if you want just the residuals vs. fitted plot
plot(lm1, which=2) # if you want just the qq plot

# Test for linear relationships within different groups of data
library(nlme)
lm_bygroup <- lmList(Sepal.Length~Petal.Length | Species,data=iris)
summary(lm_bygroup)

data<-read_csv("https://raw.githubusercontent.com/st3powers/turbsat/main/sampledata.csv")
data_wide<-data %>% select(-unit) %>% pivot_wider(names_from=variable,values_from=value)

# Fit a nonlinear model to the data
negative_power<-nls(secchi ~ 1/(a + turbidity^b), data = data_wide, start=list(a=1,b=1))
summary(negative_power)

# make predictions from the model
turbidity_gradient <- seq(min(data_wide$turbidity),max(data_wide$turbidity),length=1000)
predicted_secchi <- predict(negative_power,newdata=data.frame(turbidity=turbidity_gradient))
preds_df<- data.frame(turbidity_gradient, predicted_secchi)

# Plot the data and predictions from the fitted curve, old style
plot(secchi ~ turbidity, data = data_wide,pch = 19)
lines(predicted_secchi ~ turbidity_gradient, data= preds_df,col = "blue", lwd = 2)

# and ggplot style
data_wide %>% 
  ggplot(aes(x=turbidity,y=secchi)) +
  geom_line(data=preds_df,aes(x=turbidity_gradient,predicted_secchi),color="blue") +
  geom_point() +
  theme_bw()













