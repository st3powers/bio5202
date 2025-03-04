#1 - no code

#2a
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

ggplot(
  data = penguins,
  aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()

#2b
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

ggplot(
  data = penguins,
  aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind() +
  theme_bw() # or theme_classic(), or theme_minimal

#2c
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

pen_png <- ggplot(
  data = penguins,
  aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Bio 5202, Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind() + theme_classic()

#export PNG 4x3
png(filename="pen4x3.png", width=4,height=3,units="in",res=300)
pen_png
dev.off()

png(filename="pen6x4.png", width=6,height=4.5,units="in",res=300)
pen_png
dev.off()

# or ggsave

#3a
library(tidyverse)

#list dplyr functions
ls("package:dplyr")

#restrict list function to 6 elements
ls("package:dplyr") |> head(n=6)

#3b
library(tidyverse)
#restrict list function to 6 elements
thing<-ls("package:dplyr") |> head(n=6)
class(thing)

# OR

library(tidyverse)
library(palmerpenguins)

pen_plot <- ggplot(
  data = penguins,
  aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()

#objects
class(pen_plot) #gg, ggplot
# OR, str()

#4a
library(tidyverse)

#load CSVs
scholar_v1 <- read_csv('https://raw.githubusercontent.com/st3powers/bio5202/main/data/scholar_v1.csv')
scholar_v2 <- read_csv('https://raw.githubusercontent.com/st3powers/bio5202/main/data/scholar_v2.csv')

#scholar structure
str(scholar_v1)
str(scholar_v1)
class(scholar_v1$value) #value = char
class(scholar_v2$value) #value = num

#total citations in 2024
scholar_v2 |>
  filter(indicator == "cited2024") |>
  summarise(total_cit_2022 = sum(value, na.rm = TRUE))

#4b
library(tidyverse)

#load CSV
scholar_v2 <- read_csv('https://raw.githubusercontent.com/st3powers/bio5202/main/scholar_v2.csv')

scholar_v2 |>
  filter(indicator %in% c("cited2021","cited2022","cited2023")) |>
  group_by(personnumber) |>
  summarise(total_cit = sum(value)) |>
  arrange(-total_cit) %>% head(4)

#5a 
library(tidyverse)
library(nycflights13)

#rows
nrow(flights) #336776

#columns
ncol(flights) #19

#5b
library(tidyverse)
library(nycflights13)

#filter UA + AA, find numb rows
flights |>
  filter(carrier %in% c("UA","AA")) |>
  count()

#5c Baseballs on a plane
# volume of main deck of Boeing 747 
volume_container_m3_max <- 857 # m3 on freighter
volume_container_m3_min <- 707 # m3 on passenger craft after accounting for volume occupied by chairs 

# volume of baseball must be within range of 201.7 to 219.0 cm3 according MLB rules
volume_objects_cm3_max <- 219.0 #cm3
volume_objects_cm3_min <- 201.7 #cm3

# packing density of a sphere 
packing_density_max <- 0.74 # volume/volume
packing_density_min <- 0.64 # volume/volume
# This means 740 m3 of baseballs can fit into 1000 m3 container

# Assumptions include...   
# 1. Packing density is uniform
# 2. Container is empty of other cargo
# 3. Baseballs are perfectly spherical and all baseballs are identical
# 4. No edge effects (which would decrease the packing density if present)

volume_objects_m3_max <- volume_objects_cm3_max*10^-6
volume_objects_m3_min <- volume_objects_cm3_min*10^-6

count_max <- packing_density_max*volume_container_m3_max/volume_objects_m3_min
count_min <- packing_density_min*volume_container_m3_min/volume_objects_m3_max

count_range <- tibble(
  low = count_min,
  high=count_max
)
print(count_range)
# A tibble: 1 × 2
# low     high
# <dbl>    <dbl>
#  1 2066119. 3144175.

write_csv(count_range,"baseballsonaplane.csv")

#6a 
library(tidyverse)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  labs(
    x = "Sepal Length", y = "Sepal Width",
  ) +
  scale_color_viridis_d() + 
  theme_bw()

#6b various written responses
