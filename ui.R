library(leaflet)
library(highcharter)

navbarPage(windowTitle = "Mitchell Lisle | Marriage Survey Results", img(src = "logo.png", height = "20px"), id="nav", collapsible = TRUE,
           tabPanel("Map",
                    div(class="outer",
                        tags$head(
                          # Include our custom CSS
                          includeCSS("styles.css")
                        ),
                        
                        leafletOutput("map", width="100%", height="100%")
                    )
           )
)
