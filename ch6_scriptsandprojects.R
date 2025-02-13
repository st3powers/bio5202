
# 6.1.1 Running code

library(dplyr)
library(nycflights13)

not_cancelled <- flights |> 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled |> 
  group_by(year, month, day) |> 
  summarize(mean = mean(dep_delay))

getwd()
#> [1] "/Users/hadley/Documents/r4ds"


setwd("/path/to/my/CoolProject")

getwd()
#> [1] /Users/hadley/Documents/r4ds


library(tidyverse)

ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_hex()
ggsave("diamonds.png")

write_csv(diamonds, "data/diamonds.csv")








