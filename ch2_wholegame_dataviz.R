# 2  Data visualization
# 2.1 Introduction
# 2.1.1 Prerequisites 

library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────── tidyverse 2.0.0.9000 ──
#> ✔ dplyr     1.1.0     ✔ readr     2.1.4
#> ✔ forcats   1.0.0     ✔ stringr   1.5.0
#> ✔ ggplot2   3.4.1     ✔ tibble    3.1.8
#> ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
#> ✔ purrr     1.0.1     
#> ── Conflicts ─────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

install.packages("tidyverse")
library(tidyverse)

library(palmerpenguins)
library(ggthemes)

# 2.2 First steps
# 2.2.1 The penguins data frame

penguins
#> # A tibble: 344 × 8
#>   species island    bill_length_mm bill_depth_mm flipp…¹ body_…² sex     year
#>   <fct>   <fct>              <dbl>         <dbl>   <int>   <int> <fct>  <int>
#> 1 Adelie  Torgersen           39.1          18.7     181    3750 male    2007
#> 2 Adelie  Torgersen           39.5          17.4     186    3800 female  2007
#> 3 Adelie  Torgersen           40.3          18       195    3250 female  2007
#> 4 Adelie  Torgersen           NA            NA        NA      NA <NA>    2007
#> 5 Adelie  Torgersen           36.7          19.3     193    3450 female  2007
#> 6 Adelie  Torgersen           39.3          20.6     190    3650 male    2007
#> # … with 338 more rows, and abbreviated variable names ¹​flipper_length_mm,
#> #   ²​body_mass_g

glimpse(penguins)
#> Rows: 344
#> Columns: 8
#> $ species           <fct> Adelie, Adelie, Adelie, Adelie, Adelie, Adelie, A…
#> $ island            <fct> Torgersen, Torgersen, Torgersen, Torgersen, Torge…
#> $ bill_length_mm    <dbl> 39.1, 39.5, 40.3, NA, 36.7, 39.3, 38.9, 39.2, 34.…
#> $ bill_depth_mm     <dbl> 18.7, 17.4, 18.0, NA, 19.3, 20.6, 17.8, 19.6, 18.…
#> $ flipper_length_mm <int> 181, 186, 195, NA, 193, 190, 181, 195, 193, 190, …
#> $ body_mass_g       <int> 3750, 3800, 3250, NA, 3450, 3650, 3625, 4675, 347…
#> $ sex               <fct> male, female, female, NA, female, male, female, m…
#> $ year              <int> 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2…

# 2.2.2 Ultimate goal
# 2.2.3 Creating a ggplot

ggplot(data = penguins)

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm)
)

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
)

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point()
#> Warning: Removed 2 rows containing missing values (`geom_point()`).

penguins |>
  select(species, flipper_length_mm, body_mass_g) |>
  filter(is.na(body_mass_g) | is.na(flipper_length_mm))
#> # A tibble: 2 × 3
#>   species flipper_length_mm body_mass_g
#>   <fct>               <int>       <int>
#> 1 Adelie                 NA          NA
#> 2 Gentoo                 NA          NA

# 2.2.4 Adding aesthetics and layers

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point()

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  geom_smooth()

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth()

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth()

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth() +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()

#############################

# 2.2.5 Exercises

#################################################################
# 2.3 ggplot2 calls

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point()

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

penguins |> 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

# 2.4 Visualizing distributions
# 2.4.1 A categorical variable

ggplot(penguins, aes(x = species)) +
  geom_bar()

ggplot(penguins, aes(x = fct_infreq(species))) +
  geom_bar()

# 2.4.2 A numerical variable

ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)

ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

penguins |>
  count(cut_width(body_mass_g, 200))
#> # A tibble: 19 × 2
#>   `cut_width(body_mass_g, 200)`     n
#>   <fct>                         <int>
#> 1 [2.7e+03,2.9e+03]                 7
#> 2 (2.9e+03,3.1e+03]                10
#> 3 (3.1e+03,3.3e+03]                23
#> 4 (3.3e+03,3.5e+03]                38
#> 5 (3.5e+03,3.7e+03]                39
#> 6 (3.7e+03,3.9e+03]                37
#> # … with 13 more rows

ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 20)
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 2000)

###############################################

# 2.4.3 Exercises

###############################################

# 2.5 Visualizing relationships
# 2.5.1 A numerical and a categorical variable

ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")

ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_freqpoly(binwidth = 200, linewidth = 0.75)

ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.5)

# 2.5.2 Two categorical variables

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

#2.5.3 Two numerical variables

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()

# 2.5.4 Three or more variables

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)

###################################

# 2.5.5 Exercises

###################################

# 2.6 Saving your plots
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()
ggsave(filename = "my-plot.png")

###################################

# 2.6.1 Exercises

###################################

# 2.7 Common problems
ggplot(data = mpg) 
+ geom_point(mapping = aes(x = displ, y = hwy))