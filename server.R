library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)
library(geojsonio)
library(aws.s3)
library(reshape2)
library(data.table)
library(highcharter)

############# Same Sex Map #############
########################################
fb_geojson <- geojsonio::geojson_read("data/federal_boundaries_simple.geojson", what = "sp")
survey_results <- data.table::fread("data/survey_results.csv")
fb_geojson <- sp::merge(fb_geojson, survey_results, by = "Elect_div")

bins <- survey_results %>% distinct(yes_percent)

pal <- colorNumeric("viridis", domain = bins$yes_percent, reverse = TRUE)
########################################

function(input, output, session) {
  
  # Create the map
  output$map <- renderLeaflet({
    leaflet() %>%
      setView(133.9892578125, -28.110748760633534, 5) %>%
      addProviderTiles(providers$CartoDB.Positron, providerTileOptions(minZoom = 5, maxZoom = 13))
  })
  
  # updateSelectizeInput(session, 'search', choices = poa_geojson$POA_CODE, server = TRUE)
  
  observe({
      leafletProxy("map", data = fb_geojson) %>%
      clearShapes() %>%
      clearControls() %>%
      setView(133.9892578125, -28.110748760633534, 5) %>%
      # addTiles(urlTemplate = "https://api.mapbox.com/styles/v1/blueflagoperations/cikhjrpxc00149akpac8ui715/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoiYmx1ZWZsYWdvcGVyYXRpb25zIiwiYSI6IkZCUExBaVUifQ.Mikg2WAymjCUrFvvkMoDVw") %>%
      addPolygons(
        layerId = ~Elect_div,
        fillColor = ~pal(yes_percent),
        weight = 2,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7,
        label = paste0(fb_geojson$Elect_div, ": ", fb_geojson$yes_percent, "% YES Vote"),
        highlight = highlightOptions(
          weight = 3,
          color = "black",
          dashArray = "",
          fillOpacity = 0.7,
          bringToFront = TRUE),
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto")
        )
    
    
    
    # Once Suburb is Selected
    observeEvent(input$map_shape_mouseover$id, {
      layerid <- input$map_shape_mouseover$id
      
    })
    
  })
}
