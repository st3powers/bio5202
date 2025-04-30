# This script codes the spocc shiny app
# Note that one scripting strategy for shiny apps not employed here,
# is to separate the app code into three separate scripts: 1) global.R, 2) server.R, 3) ui.R 


# Install required packages if not already installed
#if (!requireNamespace("shiny", quietly = TRUE)) install.packages("shiny")
#if (!requireNamespace("spocc", quietly = TRUE)) install.packages("spocc")
#if (!requireNamespace("leaflet", quietly = TRUE)) install.packages("leaflet")
#if (!requireNamespace("ldata.table", quietly = TRUE)) install.packages("data.table")

# Note that quite a few lines of legacy code have been commented out below

# Load required libraries
library(tidyverse)
library(shiny)
library(spocc)
library(leaflet)
#library(data.table)
library(DT)
library(shinydashboard)
library(shinyjs)
library(dplyr)
library(htmltools)
library(shinyFeedback)
#library(shinyWidgets)

library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
#library(rnaturalearthhires)

library(tigris)
library(sf)
library(mapproj)
library(spsComps)

# Ensure `tigris` returns an `sf` object
options(tigris_use_cache = TRUE)
options(tigris_class = "sf")  # Force sf output


myModalData <- function() {
  div(id = "download_all_data",
      modalDialog(downloadButton("download1","Download csv"),
                  easyClose = TRUE, title = "Download Table")
  )
}

# set up some links and widgets, mainly for top menu

url_GBIF_format <- a("https://www.gbif.org/",style="font-weight:bold",href="https://www.gbif.org/",
                           target="_blank")

url_spocc_format <- a("https://docs.ropensci.org/spocc/",style="font-weight:bold",href="https://docs.ropensci.org/spocc/",
                     target="_blank")

urltwitter <- "https://twitter.com/intent/tweet?text=Check%20out%20this%20dashboard&url=https://waterfolk.shinyapps.io/streamcat/"

url_github_format <- a(icon("github"),style="font-weight:bold;font-size:18px",href="https://github.com/st3powers",
                       target="_blank")

url_sitepowers_format <- a(icon("home"),style="font-weight:bold;font-size:18px",href="https://sites.baylor.edu/powersresearchgroup/",
                           target="_blank")

url_twitter_format <- a(icon("twitter"),style="font-weight:bold;font-size:18px",href="https://twitter.com/st3powers/",
                        target="_blank")

url_scholar_format <- a(icon("book-open"),style="font-weight:bold;font-size:18px",href="https://scholar.google.com/citations?user=zc_JEdUAAAAJ&hl=en",
                        target="_blank")

# set up areas of interest for filtering data, besides whole world
# this can/should be expanded to a larger list of areas of interest over time
texas <- states(cb = TRUE) %>% filter(NAME == "Texas")
#usa <- ne_countries(scale = "large", country = "United States of America", returnclass = "sf")
#north_america <- ne_countries(scale = "large", continent = "North America", returnclass = "sf")
#usa<-states(cb=TRUE) %>% filter(!(NAME %in% c("Alaska","Hawaii")))
texas <- st_bbox(texas)
#usa <- st_bbox(usa)
#north_america <- st_bbox(north_america)
usa<-c(-125.0,24.4,-66.9,49.4)
north_america<-c(-170,5,-50,83)

geoms_list <- list(texas = texas, usa = usa, north_america = north_america)

# choose basemaps to make available in toggle on leaflet
providers<-c("Thunderforest.Outdoors","Esri.WorldImagery","CartoDB")

# Load a simple world basemap
world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")

# Define UI
ui <- fluidPage(
  tags$link(
    rel = "stylesheet",
    href = "https://fonts.googleapis.com/css2?family=Merriweather&display=swap"
  ),
  dashboardPage(
    skin = "blue",
#    title = paste0(""),
#    title("Species Occurrence Dashboard"),
    #    title = paste0("StreamCat Dashboard"),
    
    # HEADER ---------------------------------------------------------------------
    dashboardHeader(
#      title = paste0(""),
#      title("Species Occurrence Dashboard"),
      
#      p(span("This app retrieves species location data from GBIF- Global Biodiversity Information Facility ",style="font-weight:bold"),url_GBIF_format),
#      p(span('See Owens H, Barve V, Chamberlain S (2024). spocc: Interface to Species Occurrence Data Sources. R package version 1.2.3', url_spocc_format)),
      
      #        title = paste0("StreamCat Dashboard"),
#      titleWidth = 300,
      
      tags$li(# Creating a link to the CRASR website
        url_sitepowers_format,
        class = "dropdown"),
      tags$li(# Creating a link to the GitHub
        url_scholar_format,
        class = "dropdown"),
      tags$li(# Creating a link to the GitHub
        url_github_format,
        class = "dropdown")#,
#      tags$li(# Creating a link to twitter
#        url_twitter_format,
#        class = "dropdown")
      
    ),

dashboardSidebar(
  width = 300,
  sidebarMenu(
#      p("This app retrieves data from GBIF- Global Biodiversity Information Facility"),#, https://www.gbif.org/"),
#      tags$a(href= "https://www.gbif.org/", "https://www.gbif.org/"),

      fluidRow(
        column(width = 10,
      textInput("species_input", "Taxon name- accepts multiple separated by comma", value = "Alligator mississippiensis"),
      numericInput("recordlimit", "Record limit- be patient if you increase this", value = 500),
      dateInput("startdate", "Start date", value = "1980-01-01"),
      dateInput("enddate", "End date", value = Sys.Date()),
      selectInput("geom", "Bounding box", choices = c("World", "Texas", "USA lower 48", "North America")),
      selectInput("source", "Data provider", 
                  choices = c("gbif"))#,#,"inat","ebird","vertnet","idigbio","obis","ala")),
#      ),
#      actionButton("download_bAlligator mississippiensisutton", "Get data")#,
 #     loadingButton("download_button", "Get data")#,
#      checkboxInput("remove_na", "Remove NA Coordinates", value = FALSE)
    )))),
    dashboardBody(
            p(span("This app retrieves species location data from GBIF- the Global Biodiversity Information Facility ",style="font-weight:bold"),url_GBIF_format),
            p(span('Choose your query criteria in the sidebar at left. Then click GET DATA.')),
            p(span('See Owens H, Barve V, Chamberlain S (2024). spocc: Interface to Species Occurrence Data Sources. R package version 1.2.3', url_spocc_format)),
            div(loadingButton("download_button", "GET DATA"),class="text-center"),
#            p(span('See Owens H, Barve V, Chamberlain S (2024). spocc: Interface to Species Occurrence Data Sources. R package version 1.2.3', url_spocc_format)),
            p(),
      leafletOutput("map"),
      
      textOutput(outputId="message_largetable"),
      fluidRow(
        #       column(width = 12,
        box(width = 12,title="Data",
            #                   collapsible = TRUE,
            #                   title = "Data",
            downloadButton('download1', 'Download csv'),
            dataTableOutput("tabledata")
        ) # close box
      ), # close column
      
#      fluidRow(
#        box(width = 12,title="Options",
#               selectInput("count_column", "Which count?", choices = ""),
#               checkboxInput("log10", "Log10 transform", value = 0)
#        )),
      
      fluidRow(column(width = 12,
                      box(width = NULL,
                          collapsible = TRUE,
                          title = "Heatmap",
                          selectInput("count_column", "Which count?", choices = ""),
                          checkboxInput("log10", "Log10 transform", value = 0),
                          plotOutput("plot_speciescount")
      )))
      
    )
  )
)

# Define server
server <- function(input, output) {
  
  reactive_message_largetable<-reactiveVal()
  
  # Reactive values to store downloaded data
  species_data <- reactiveVal(NULL)

  bbox_table <- reactiveVal(value = data.frame(
    lat = numeric(),
    lon = numeric()
    ))
  
  hex_data <- reactiveVal()
  basemap <- reactiveVal()
#  reactiveplot_speciescount<-reactiveVal()
#  reactiveplot_speciescount_log10<-reactiveVal()
  
  observeEvent(input$download_button, {
    # Download data when button is clicked
#    species <- input$species_input
    print(input$species_input)
    species <-  unlist(strsplit(input$species_input,","))
#    species[grep("* ",species)]<-substr(species[grep("* ",species)],1,
#                                        nchar(species[grep("* ",species)]))
#    species <- paste(input$species_input,collapse=",")
    print(species)
    # Revised below line, which threw an error
#    occurrences <- spocc::occ(species = species) 
#    occurrences <- spocc::occ(query = species,from ='gbif')#,limit=5) # new code
#    occurrences <- spocc::occ(query = species,from ='gbif',limit=10000) # new code
    geom_use<-input$geom
    if(geom_use=="World"){
      occurrences <- #tryCatch(
      spocc::occ(query = species,from =input$source,limit=input$recordlimit, 
                                date=c(input$startdate,input$enddate))
#      )
      obj_string <- paste(capture.output(print(occurrences)), collapse = "\n")
      norecords<-grep("Found: 0",obj_string)
      if(length(norecords)>0){
        resetLoadingButton("download_button") 
        shinyCatch(stop("No records found. Adjust your query inputs?"), blocking_level = "error")
      }
    }
#    print("did first if")
    if(geom_use=="Texas"){geom<-geoms_list$texas}
#    print("did second if")
    if(geom_use=="USA lower 48"){geom<-geoms_list$usa}
#    print("did third if")
    if(geom_use=="North America"){geom<-geoms_list$north_america}
      
    if(geom_use!="World"){  
      occurrences <- #tryCatch(
        spocc::occ(query = species,from =input$source,limit=input$recordlimit, 
        date=c(input$startdate,input$enddate),
        geometry=geom)
      
      obj_string <- paste(capture.output(print(occurrences)), collapse = "\n")
      norecords<-grep("Found: 0",obj_string)
      if(length(norecords)>0){
        resetLoadingButton("download_button") 
        shinyCatch(stop("No records found. Adjust your query inputs?"), blocking_level = "error")
      }
      
#      )
    }
    
#    occurrences <- spocc::occ(query = species,from =c('gbif,inat,ebird,vertnet,idigbio,obis,ala'),limit=input$recordlimit, 
#                              date=c(input$startdate,input$enddate),
#                              geometry=geom)
#    occurrences <- spocc::occ(query = species,from =c('ebird'),limit=input$recordlimit, 
#                              ebirdopts = list(key = "knm5ljjamos7"))
#    })

#    occurrences <- spocc::occ(query = "alligator mississippiensis",from ='gbif',limit=500, 
#                              geometry=texas)
#    occurrences <- spocc::occ(query = "Haliaeetus leucocephalus",from ='ebird',limit=input$recordlimit,
#                              ebirdopts = list(key = "knm5ljjamos7"))
        
    
    
    
#    occurrences <- bind_rows(occurrences$data)
#    spocc::occ(query = 'Haliaeetus leucocephalus',limit=5) 
#    spocc::occ(query = c('Haliaeetus leucocephalus','Oncorhynchus mykiss'))
    
    occurrences<- bind_rows(occurrences$gbif$data) %>% as.data.frame()
    occurrences<- occurrences %>% filter(!is.na(longitude) & !is.na(latitude))
    
    # Added the below lines, to remove species name from column names. spocc::occ() puts the species name as prefix in column names.
    speciesprefix<-paste(input$species_input,".",sep="") # new code
    speciesprefix<-gsub(" ","_",speciesprefix) # new code
    names(occurrences)<-gsub(speciesprefix,"",names(occurrences))  # new code
    

#    if (input$remove_na) {
      # Remove records with NA values for coordinates
      # Revise the below line, which throws an error when no occurrence records are found
#      occurrences <- occurrences[complete.cases(occurrences$lat, occurrences$lon), ]

#      if(length(occurrences)>0){ # new code
#      occurrences <- occurrences[complete.cases(occurrences$latitude, occurrences$longitude), ] # new code, with column names corrected
#      } # new code
#    }
    
    # Update reactive values
    species_data(occurrences)
    
    data<-occurrences
    print(head(data))
    
    data_count<- data %>% select(name) %>%
      group_by(name) %>% 
      summarize(ct = length(name))
    
    data_countbyyear<- data %>% select(year,name) %>%
      group_by(name,year) %>% 
      summarize(ct = length(name))
    
    data_countbymonth<- data %>% select(month,name) %>%
      group_by(name,month) %>% 
      summarize(ct = length(name))
    
    data_countbyyearmonth<- data %>% select(year,month,name) %>%
      group_by(name,year,month) %>% 
      summarize(ct = length(name))
    
    ##########################
    # Convert to sf object
    
    print("got here")
    head(data)
    print(sum(is.na(data$longitude)))
    print(sum(is.na(data$latitude)))
    occurrences_sf <- st_as_sf(data, coords = c("longitude", "latitude"), crs = 4326)
    print("got here 2")
    
    # Define hexbin area (e.g., 1000 km²), convert to an equal-area projection
    equal_area_crs <- "+proj=cea +lon_0=0 +lat_ts=30 +datum=WGS84"
    occurrences_sf <- st_transform(occurrences_sf, crs = equal_area_crs)
    
    # Define hexbin size (~1000 km² area, requires experimentation)
    hex_size <- sqrt(2 * 1000 * 1e6 / (3 * sqrt(3)))  # Approximate hexagon radius in meters
    hex_size <- hex_size *10
    
    # Create hexagonal grid
    bbox <- st_bbox(occurrences_sf)
    #bbox[c(1, 3)] <- bbox[c(1, 3)] + c(-100000, 100000)  # Expand longitude range
    #bbox[c(2, 4)] <- bbox[c(2, 4)] + c(-100000, 100000)  # Expand latitude range
    
    hexbins <- st_make_grid(st_as_sfc(bbox), cellsize = hex_size, square = FALSE) %>%
      st_sf()
    
    # Compute intersection of points and hexagons
    intersects_list <- st_intersects(hexbins, occurrences_sf)
    
    # Count total occurrences and unique species per hexbin
    hex_summary <- data.frame(
      hex_id = seq_along(intersects_list),
      total_occurrences = sapply(intersects_list, length),  # Total number of observations
      unique_species_count = sapply(intersects_list, function(indices) {
        if (length(indices) > 0) length(unique(occurrences_sf$name[indices])) else 0
      })
    )
    
    # Extract species count per hexbin
    species_counts_list <- lapply(seq_along(intersects_list), function(i) {
      if (length(intersects_list[[i]]) > 0) {
        species_counts <- table(occurrences_sf$name[intersects_list[[i]]])
        data.frame(
          hex_id = rep(i, length(species_counts)),  # Ensure same length for all columns
          species = names(species_counts),
          count = as.integer(species_counts)
        )
      } else {
        data.frame(hex_id = i, species = NA, count = NA)  # Placeholder for empty hexbins
      }
    })
    
    # Combine all hexbin species data into a single dataframe
    species_counts_df <- do.call(rbind, species_counts_list) %>%
      filter(!is.na(species))  # Remove placeholder rows
    
    # Reshape into wide format: one column per species
    hex_counts_wide <- species_counts_df %>%
      pivot_wider(names_from = species, values_from = count, values_fill = 0)
    
    # Merge with hex summary data and hexbins geometry
    hex_counts <- hexbins %>%
      mutate(hex_id = row_number()) %>%
      left_join(hex_summary, by = "hex_id") %>%  # Add total occurrences & unique species count
      left_join(hex_counts_wide, by = "hex_id") %>%  # Add species columns
      replace(is.na(.), 0)  # Replace NAs with 0 for species counts
    
    hex_counts <- hex_counts %>% filter(total_occurrences>0)
    
    # Transform world basemap to match hexbin projection
    world <- st_transform(world, crs = st_crs(hex_counts))
    
    world_clipped<-world
    if(input$geom!="World"){
    world_clipped <- st_crop(world, st_bbox(hex_counts))
    }
    
    hex_data(hex_counts)
    basemap(world_clipped)
    
#    updateSelectInput(inputId = "count_column",label="",
#                      choices=names(hex_counts)[-which(names(hex_counts) %in% c("hex_id","geometry"))])
    
    updateSelectInput(inputId = "count_column", label = "",
                      choices = setNames(
                        names(hex_counts)[!names(hex_counts) %in% c("hex_id", "geometry")],
                        recode(
                          names(hex_counts)[!names(hex_counts) %in% c("hex_id", "geometry")],
                          unique_species_count = "Richness",
                          total_occurrences = "Total occurrences"
                        )
                      )
    )
    
#    
#    plot_speciescount_log10<-
#      hex_counts %>% mutate(count=input$count_column) %>%
#      ggplot() +
#      geom_sf(data = world_clipped, fill = "gray90", color = "white", size = 0.2) +  # Light land background
#      geom_sf(aes(fill = log10(count),color=log10(count)), size = 0.1) +
#      scale_fill_viridis_c() +
#      scale_color_viridis_c() +
#      theme_minimal()
    
#    reactiveplot_speciescount_log10(plot_speciescount_log10)
  })
  
  output$map <- renderLeaflet({
    # Render map based on downloaded data
    
#    la1<-min(bbox_table()$lat,na.rm=TRUE)
#    la2<-max(bbox_table()$lat,na.rm=TRUE)
#    ln1<-min(bbox_table()$lon,na.rm=TRUE)
#    ln2<-max(bbox_table()$lon,na.rm=TRUE)
    
    map <- leaflet() %>%
      addTiles() %>%
      setView(lng = 0, lat = 0, zoom = 2) %>%
      addProviderTiles(providers[1],group=providers[1]) %>%
      addProviderTiles(providers[2],group=providers[2]) %>% 
      addProviderTiles(providers[3],group=providers[3]) %>% 
      addLayersControl(baseGroups=providers, options = 
                         layersControlOptions(collapsed=TRUE)) 
    
#    map<- map %>%
#      fitBounds(lat1=la1,lat2=la2,
#                lng1=ln1,lng2=ln2)    
    
    map$x$options = append(map$x$options, list("attributionControl" =FALSE))
    
    data <- species_data()

#    bbox_table()$lat<-data$latitude
#    bbox_table()$lon<-data$longitude
    
    if(length(data[,1])>=1){
    
    la1<-min(data$latitude,na.rm=TRUE)
    la2<-max(data$latitude,na.rm=TRUE)
    ln1<-min(data$longitude,na.rm=TRUE)
    ln2<-max(data$longitude,na.rm=TRUE)
    
    map<- map %>% fitBounds(lat1=la1,lat2=la2,
                lng1=ln1,lng2=ln2)
    }
    # The below code had a few problems
    # The if statement is error prone. Data can be a data frame with 0 columns and 0 rows, which returns FALSE when is.null(data) is called. 
    # Also, some of of the column names were incorrectly specified - latitude rather than lat, longitude rather than lon
    
    # if (!is.null(data)) {
    # map <- addMarkers(map, data = data, lat = ~lat, lng = ~lon,
    #                        popup = ~paste("Species: ", species_data()$species))
    # }    
    
    # if (!is.null(data)) { 
    if(length(data)>0) { # revised code
      
      if(nrow(data)<=1000){
        reactive_message_largetable("")
      }
      
      if(nrow(data)>1000){
        reactive_message_largetable("Large table- Only a subset of site locations are mapped above. The complete set of records is shown in the table below.")
#        data<-data[1:1000,]
        # randomly sample rows from the data
        data<-data[sample(1:length(data[,1]),size=1000),]
      }
      
      labs<-lapply(seq(nrow(data)), function(i) {
        paste0( data[i, "name"], '<br>', 
#                data[i, "verbatimLocality"], '<br>', 
                ifelse(is.na(data[i, "verbatimLocality"]), "no locality info", data[i, "verbatimLocality"]), '<br>',
#                "recorded by ",data[i, "recordedBy"],' on ',
                ifelse(is.na(data[i, "recordedBy"]), "recorded by unknown", paste("recorded by",data[i, "recordedBy"])), '<br>',
                data[i, "eventDate"], '<br>',
                ifelse(is.na(data[i, "lifeStage"]), "", paste("life stage",data[i, "lifeStage"])),
                ifelse(is.na(data[i, "vitality"]), "", paste("",data[i, "vitality"])), 
                ifelse(is.na(data[i, "occurrenceRemarks"]), "", paste("",data[i, "occurrenceRemarks"])),'<br>',
                ifelse(is.na(data[i, "references"]), "", paste("",data[i, "references"]))
      )
      })
      
      links <- sapply(seq(nrow(data)), function(i) {
        paste0('<a href="', data[i, "references"], '" target="_blank">', data[i, "references"], '</a>')
      })
      data$popup<-links
#      map <- addMarkers(map, data = data, lat = ~lat, lng = ~lon,
      map <- addMarkers(map, data = data, lat = ~latitude, lng = ~longitude,# # revised code
#                        popup = ~paste("Species: ", species_data()$name))  # sure, but we can just call data, which is identical to species_data()
                        #label = ~paste(paste(data$name,", ",data$verbatimLocality,", identified by ", data$identifiedBy,sep=""))) # revised code
#                        label = ~paste(paste(data$name,"</p><p>",data$verbatimLocality,"</p><p>","identified by ", data$identifiedBy," on ", data$eventDate, sep=""))) # revised code
                label=lapply(labs, htmltools::HTML),
            popup= ~popup) 
    }
    resetLoadingButton("download_button") 
    map
    
  })
  

  
   
#  plot_speciescount_log10<-reactive({
#    dataplot<-datause()
#  })
  
  
  output$message_largetable<- renderText({
    reactive_message_largetable()
  })
  
  output$tabledata <- renderDataTable(server=TRUE,#{
                                      datatable(species_data(), 
                                                rownames= FALSE, selection = 'none',
                                                options = list(dom = 'Bfrtip', scrollX = TRUE, scrollCollapse = TRUE,
                                                               scrollY = "70vh", pageLength = 100)))#,
  
  output$download1 <- downloadHandler(
    filename = function() {
#      paste(gsub(" ","_",input$species_input), "_",Sys.Date(),".csv",sep = "")
      paste(gsub(" ","_",input$species_input), "_",Sys.Date(),"_","lim",input$recordlimit,"_",year(input$startdate),"_",year(input$enddate),".csv",sep = "")
    },
    content = function(file) {
      write_csv(species_data(), file)
    }
  )
  
  plot_speciescount_log10<-reactive({
    req(hex_data(),input$count_column)
    plot_speciescount_log10<-
      hex_data() %>% mutate(count = log10(.data[[input$count_column]])) %>%
      select(count) %>% filter(count>=0) %>%
      ggplot() +
      geom_sf(data = basemap(), fill = "gray90", color = "white", size = 0.2) +  # Light land background
      geom_sf(aes(fill = count,color=count), size = 0.1) +
      scale_fill_viridis_c() +
      scale_color_viridis_c() +
      theme_minimal()+
      labs(fill="Log10\ncount", color="Log10\ncount") +
      coord_sf(crs = "+proj=moll")  # Apply Mollweide projection
    plot_speciescount_log10
  })
  
  plot_speciescount<-reactive({
    req(hex_data(),input$count_column)
    plot_speciescount<-
      hex_data() %>% mutate(count = .data[[input$count_column]]) %>%
      select(count) %>% filter(count>0) %>%
      ggplot() +
      geom_sf(data = basemap(), fill = "gray90", color = "white", size = 0.2) +  # Light land background
      geom_sf(aes(fill = count,color=count), size = 0.1) +
      scale_fill_viridis_c() +
      scale_color_viridis_c() +
      theme_minimal() +
      coord_sf(crs = "+proj=moll")  # Apply Mollweide projection
    plot_speciescount
  })  
    
  
#  observeEvent(input$download_button, {
#    req(hex_data())
#    reactiveplot_speciescount("")
#    reactiveplot_speciescount_log10("")
#  })
  
  output$plot_speciescount <- renderPlot({
    req(plot_speciescount(),plot_speciescount_log10())
    if(input$log10==0){
    plotit<-plot_speciescount()
    }  
    if(input$log10==1){
    plotit<-plot_speciescount_log10()
    }  
    plotit
  })
  
#  updateLoadingButton(session, "download_button", label = "Load Data")

#  output$download1 <- downloadHandler(
#    filename = function() {
#      paste("Data_", gsub("-","_",Sys.Date()), ".csv", sep="")
#    },
#    content = function(file) {
#      write.csv(species_data(), file)
#    })
    

}

# Run the Shiny app
shinyApp(ui, server)
