
# load an already installed package
library(ggplot2)
library(tidyverse)
library(data.table)
library(ggthemes)
library(readxl)
library(janitor) # check out clean_names function to clean up column names

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

# read in a large csv file (>400 MB)
url<-"https://github.com/waterfolk/NLAdata/raw/master/daterr.csv"
then<-now()
bigdata_fread<-fread(url, header =  TRUE, sep = ',' , stringsAsFactors=FALSE,
                      colClasses="character")
now() - then

# alternatives to fread(), which are usually slower, sometimes by lot
then<-now()
bigdata_read_csv<-read_csv(url)
now() -then

then<-now()
bigdata_read.csv<-read.csv(url)
now() -then

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


# clear everything - remove all loaded objects from the current session/environment
rm(list = ls())

# a way to create tables 'manually'

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


# tallying up various summary stats
library(nycflights13)

# mean, max, min
flights %>% group_by(year,carrier) %>%
  summarize(count = length(year),
            air_time_mean = mean(air_time, na.rm=TRUE),
            air_time_max = max(air_time, na.rm=TRUE),
            air_time_min = min(air_time, na.rm=TRUE)) %>% View()

# percentiles
flights %>% group_by(year,carrier) %>%
  summarize(
    pct_5th = quantile(air_time, probs = 0.05, na.rm=TRUE),
    pct_25th = quantile(air_time, probs = 0.25, na.rm=TRUE),
    pct_50th  = quantile(air_time, probs = 0.5, na.rm=TRUE),
    pct_75th = quantile(air_time, probs = 0.75, na.rm=TRUE),
    pct_95th = quantile(air_time, probs = 0.95, na.rm=TRUE)) %>% 
  View()

# succint ways to summarize multiple columns of numeric data, without naming every column

iris %>% group_by(Species) %>% 
  select_if(is.numeric) %>%
  summarize_all(list(mean=mean,med=median,ct=length)) %>% 
  View()

# reshaping data

# make longer with only one value per row
# this is the dplyr way

flights_long <- flights %>%
  pivot_longer(
    cols = where(is.numeric),
    names_to = "variable",
    values_to = "value") %>% as.data.frame()

View(flights_long)

# another way to make longer with only one value per row
# this is the old school way that using reshape2::melt() which has helpful defaults
library(reshape2)
flights_long2 <- melt(flights)

View(flights_long2)

# reshape long data into wide data
# note that the original flights data frame is already wide data
# but this shows a way to get wide data if didn't already have it
flights_wide <- flights_long %>% pivot_wider(names_from=variable,
                             values_from=value)

#####################################################

# handling dates

library(data.table)
library(anytime)
PATH<-"https://raw.githubusercontent.com/waterfolk/waterfolkdata/main/samples.csv"
data<-fread(PATH)

names(data)
head(data$datecollect)
anytime::anydate(data$datecollect)
data$datecollect_format<- anytime::anydate(data$datecollect)

# alternatively 

library(lubridate)
format(lubridate::mdy(data$datecollect), "%Y-%m-%d")
data$datecollect_format_ymd<- format(lubridate::mdy(data$datecollect), "%Y-%m-%d")

#####################################

# factors, and releveling of factors

data$system_factor <-  factor(data$system)
levels(data$system_factor)
data$system_factor_reordered<-relevel(data$system_factor, ref = "Waco Cr")
levels(data$system_factor_reordered)

data2 <- data %>% filter(system %in% c("Brazos River", "Fort Parker Lake", "Lake Arrowhead")) 
data2$system_factor <-  factor(data2$system)
levels(data2$system_factor)
data2$system_factor_reordered<-factor(data2$system, levels=c("Fort Parker Lake","Lake Arrowhead","Brazos River"))
levels(data2$system_factor_reordered)

##################################################

# Functions

# Coefficient of Variation (CV)
CV <- function(x, na.rm = FALSE) {
  sd(x, na.rm = na.rm) / mean(x, na.rm = na.rm)
}

CV(iris$Sepal.Length)

iris %>% select(Species, Sepal.Length) %>%
  group_by(Species) %>%
  summarize(cv=CV(Sepal.Length))

# Mean Absolute Deviation (MAD)
mad <- function(x) {
  mean(abs(x - mean(x)))
}

mad(iris$Sepal.Length)

# Custom function to plot histogram with specified binwidth
plot_custom_hist <- function(data, binwidth) {
  hist(data, breaks = seq(min(data), max(data) + binwidth, by = binwidth),
       main = "Histogram with Custom Bins", xlab = "Value", ylab = "Frequency")
}

plot_custom_hist(iris$Sepal.Length, 0.5)
