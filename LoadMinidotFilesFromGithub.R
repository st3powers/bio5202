# This script provides an example of how many large files (with a common structure) can be loaded from a private Github repository

# Start with a clean slate
rm(list=ls())

library(httr)
library(tidyverse)
library(data.table)

# Set your GitHub personal access token
token <- "NotTheActualToken"

github_auth <- authenticate(token, "", type = "basic")

username <- "waterfolk"
repo <- "waterfolk/Minidot"

# Replace 'username' with your GitHub username and 'Minidot' with your repository name
url <- "https://api.github.com/repos/waterfolk/Minidot/git/trees/main?recursive=1"
response <- GET(url, authenticate(token, "", type = "basic"))
content <- content(response, "parsed")

# Extract paths for 'Cat.TXT' files
file_paths <- sapply(content$tree, function(x) if(grepl("Cat.TXT$", x$path)) x$path)
file_paths <- Filter(Negate(is.null), file_paths)
file_paths <- unlist(file_paths)

file_paths <- file_paths[grep("MillerPonds",file_paths)]

# Function to read a single CSV file from a private GitHub repository
# With some specifics for the Minidot Cat files
read_csv_from_github <- function(repo, path, token) {
  url <- paste0("https://raw.githubusercontent.com/", repo, "/main/", path)
  res <- GET(url, authenticate(token, ""))
  
  print(url)
  
  if (status_code(res) == 200) {
    datai <- content(res, "text") %>%
      fread()
    #      read_csv()  # or fread if using data.table
    datai<-datai[-1,] # remove the line that contains only units
    
    # get sensor serial number from second line of Cat file
    linesi <- readLines(textConnection( content(res, "text")))
    seriali <- linesi[2]
    seriali<-gsub("Sensor: | ","",seriali)
    
    # get text for naming the deployment
    deploymenti<-gsub("/","_",path)
    deploymenti<-gsub("_Cat.TXT","",deploymenti)
    
    # add columns to data
    datai<- datai %>% mutate(serial=seriali,
                             deployment=deploymenti,
                             path_long=path)
    return(datai)
    
  } else {
    stop("Failed to download file: ", path)
  }
}

data_list <- lapply(file_paths, read_csv_from_github, repo = repo, token = token)
