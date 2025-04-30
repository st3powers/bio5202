# Install required packages if not already installed
if (!requireNamespace("shiny", quietly = TRUE)) install.packages("shiny")
if (!requireNamespace("spocc", quietly = TRUE)) install.packages("spocc")
if (!requireNamespace("leaflet", quietly = TRUE)) install.packages("leaflet")

# Load required libraries
library(shiny)
library(spocc)
library(leaflet)

# Define UI
ui <- fluidPage(
  titlePanel("Species Occurrence Map"),
  sidebarLayout(
    sidebarPanel(
      textInput("species_input", "Enter Species:", value = "Erica plena"),
      actionButton("download_button", "Download Data"),
      checkboxInput("remove_na", "Remove NA Coordinates", value = TRUE)
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
)

# Define server
server <- function(input, output) {
  
  # Reactive values to store downloaded data
  species_data <- reactiveVal(NULL)
  
  observeEvent(input$download_button, {
    # Download data when button is clicked
    species <- input$species_input
    
    # Revised below line, which threw an error
#    occurrences <- spocc::occ(species = species) 
    occurrences <- spocc::occ(query = species,from ='gbif',limit=5) # new code
    
    occurrences<-occurrences$gbif$data %>% as.data.frame()
    
    # Added the below lines, to remove species name from column names. spocc::occ() puts the species name as prefix in column names.
    speciesprefix<-paste(input$species_input,".",sep="") # new code
    speciesprefix<-gsub(" ","_",speciesprefix) # new code
    names(occurrences)<-gsub(speciesprefix,"",names(occurrences))  # new code

    if (input$remove_na) {
      # Remove records with NA values for coordinates
      # Revise the below line, which throws an error when no occurrence records are found
#      occurrences <- occurrences[complete.cases(occurrences$lat, occurrences$lon), ]

      if(length(occurrences)>0){ # new code
      occurrences <- occurrences[complete.cases(occurrences$latitude, occurrences$longitude), ] # new code, with column names corrected
      } # new code
    }
    
    # Update reactive values
    species_data(occurrences)
  })
  
  output$map <- renderLeaflet({
    # Render map based on downloaded data
    map <- leaflet() %>%
      addTiles() %>%
      setView(lng = 0, lat = 0, zoom = 2)
    
    data <- species_data()
    
    # The below code had a few problems
    # The if statement is error prone. Data can be a data frame with 0 columns and 0 rows, which returns FALSE when is.null(data) is called. 
    # Also, some of of the column names were incorrectly specified - latitude rather than lat, longitude rather than lon
    
    # if (!is.null(data)) {
    # map <- addMarkers(map, data = data, lat = ~lat, lng = ~lon,
    #                        popup = ~paste("Species: ", species_data()$species))
    # }    
    
    # if (!is.null(data)) { 
    if(length(data)>0) { # revised code
#      map <- addMarkers(map, data = data, lat = ~lat, lng = ~lon,
      map <- addMarkers(map, data = data, lat = ~latitude, lng = ~longitude,# # revised code
#                        popup = ~paste("Species: ", species_data()$name))  # sure, but we can just call data, which is identical to species_data()
                        popup = ~paste("Species: ", data$name)) # revised code
    }
    
    map
  })
}

# Run the Shiny app
shinyApp(ui, server)
