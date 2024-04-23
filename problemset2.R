# 1 

rm(list=ls())

print(getwd())

myvector <- df[,2]
myvector <- df[[2]]
myvector <- df[['second_column_name']]
myvector <- as.vector(df['second_column_name'])

library(tidyverse)

samples <- read.csv(url("https://raw.githubusercontent.com/waterfolk/waterfolkdata/main/samples.csv"))
as.Date(samples$datecollect, format = "%m/%d/%Y")
lubridate::mdy(samples$datecollect)

samples <- read.csv(url("https://raw.githubusercontent.com/waterfolk/waterfolkdata/main/samples.csv")) %>% 
  mutate(date=as.Date(datecollect, format = "%m/%d/%Y"))

mutate(.data =read.csv("https://raw.githubusercontent.com/waterfolk/waterfolkdata/main/samples.csv"), datecollect = anytime(.data$datecollect))

#############################################

# 2

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = drv)) + 
  geom_smooth()


plot2 <- ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = drv)) + 
  geom_smooth() +
  theme_minimal() +
  scale_color_viridis_d()

ggsave("plot2.png", plot2, width = 4, height = 3)

plot2b <- ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = drv)) + 
  geom_smooth() +
  theme_minimal() +
  scale_color_viridis_d()

ggsave("plot2b.png", plot2b, width = 6, height = 4.5)

##############################################

# 3 

library(dplyr)

#load baylor_majors from github
baylor_majors <- read.csv(url("https://raw.githubusercontent.com/st3powers/bio5202/main/baylormajors.csv"))

# sum the count column for each major 
sum_by_degreename <- baylor_majors %>%
  group_by(degreetype, degreename) %>%
  summarize(total_count = sum(count))

# sort the sum_by_degreename dataset by total_count column in descending order
sorted_sum <- sum_by_degreename %>%
  arrange(desc(total_count))

# select the top 20 degrees
top_20_counts <- head(sorted_sum, 20)

# print the top degrees table 
print(top_20_counts)

# filter the sorted_sum dataset to include only BS degrees in the degreetype column
bs_degrees <- sorted_sum %>%
  filter(degreetype == "BS")

# select the top 20 BS degrees
top_20_bs_counts <- head(bs_degrees, 20)

# print the top 20 BS degrees table
print(top_20_bs_counts)


# Or

majors %>%
  group_by(degreename, degreetype) %>%
  summarize(total_students = sum(count)) %>%
  arrange(desc(total_students)) %>%
  head(20)

majors %>%
  filter(degreetype == "BS") %>%
  group_by(degreename, degreetype) %>%
  summarize(total_students = sum(count)) %>%
  arrange(desc(total_students)) %>%
  head(20)


##############################################

# 4 no code

##############################################

# 5 no code

##############################################

# 6 

ggplot(mpg) +
  stat_summary(
    aes(x=hwy,y=model),
    fun.min=min,
    fun.max=max,
    fun=median
    ) +
  theme_bw()


mpg$model=with(mpg,reorder(model,hwy,mean))

# not quite 
# mpg$model <- factor(mpg$model, levels = unique(mpg$model[order(mpg$hwy)]))

ggplot(mpg) + 
  stat_summary(
    aes(x=hwy, y=model),
    fun.min=min,
    fun.max=max,
    fun=median
  )

# Or 
ggplot(mpg)+
  stat_summary(aes(x=hwy, y=reorder(model,hwy)),
               fun.min = min, 
               fun.max = max, 
               fun = median) + scale_color_colorblind()+ theme_bw() 

# Or 

ggplot(mpg) +
  stat_summary(
    aes(x = hwy, y = fct_reorder(model,hwy,mean)),
    fun.min = min,
    fun.max = max,
    fun = median
  ) + theme_bw() + ylab("model")

# Or

mpg|>
  mutate(model = fct_reorder(model, hwy, .fun='median')) |>
  ggplot() +
  stat_summary(
    aes( x = hwy, y = model),
    fun.min = min,
    fun.max = max,
    fun = median
  )+
  theme_bw()

# bonus 

ggplot(mpg) + 
  stat_summary(
    aes(x=hwy, y=model),
    fun.min=function(x) quantile(x, 0.05),
    fun.max=function(x) quantile(x, 0.95),
    fun=median
  )









