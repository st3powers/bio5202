# From Ch 2-The Very Basics 
# "Hands-On Programming with R" Grolemund
# https://rstudio-education.github.io/hopr/

1 + 1
#> [1] 2

100:130
#> [1] 100 101 102 103 104 105 106 107 108 109 110 111 112
#> [14] 113 114 115 116 117 118 119 120 121 122 123 124 125
#> [25] 126 127 128 129 130


3 % 5
#> Error: unexpected input in "3 % 5"
 
2 * 3   
#> 6
 
4 - 1   
#> 3

6 / (4 - 1)   
#> 2


10 + 2
#> 12

12 * 3
#> 36

36 - 6
#> 30

30 / 3
#> 10 

1:6
#> 1 2 3 4 5 6

a <- 1
a
#> 1

a + 2
#> 3

die <- 1:6

die
#> 1 2 3 4 5 6

my_number <- 1
my_number 
#> 1

my_number <- 999
my_number
#> 999

ls()
#> "a"         "die"       "my_number" "name"     "Name"    

die - 1
#> 0 1 2 3 4 5

die / 2
#> 0.5 1.0 1.5 2.0 2.5 3.0

die * die
#> 1  4  9 16 25 36

1:2
#> 1 2

1:4
#> 1 2 3 4

die
#> 1 2 3 4 5 6

die + 1:2
#> 2 4 4 6 6 8

die + 1:4
#> 2 4 6 8 6 8
#> Warning message:
#>  In die + 1:4 :
#>  longer object length is not a multiple of shorter object length

die %*% die
## 91

die %o% die
#>      [,1] [,2] [,3] [,4] [,5] [,6]
#> [1,]    1    2    3    4    5    6
#> [2,]    2    4    6    8   10   12
#> [3,]    3    6    9   12   15   18
#> [4,]    4    8   12   16   20   24
#> [5,]    5   10   15   20   25   30
#> [6,]    6   12   18   24   30   36
  
round(3.1415)
#> 3

factorial(3)
#> 6

mean(1:6)
#> 3.5

mean(die)
#> 3.5

round(mean(die))
#> 4

sample(x = 1:4, size = 2)
#> 3 2

sample(x = die, size = 1)
#> 2

sample(x = die, size = 1)
#> 1

sample(x = die, size = 1)
#> 6

sample(die, size = 1)
#> 2

round(3.1415, corners = 2)
#> Error in round(3.1415, corners = 2) : unused argument(s) (corners = 2)

args(round)
#> function (x, digits = 0) 
#> NULL

round(3.1415)
#> 3

round(3.1415, digits = 2)
#> 3.14

sample(die, 1)

sample(size = 1, x = die)

sample(die, size = 2)

sample(die, size = 2, replace = TRUE)

sample(die, size = 2, replace = TRUE)

dice <- sample(die, size = 2, replace = TRUE)
dice

sum(dice)

dice

#######################################
# 2.4 Writing Your own Functions

roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}

roll()

