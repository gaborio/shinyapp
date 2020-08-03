#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#######packages and data
library(shiny)
library(tidyverse)
library(readxl)
library(ggthemes)


respu.data <- read_delim("BD_Audiencias_sample.csv", delim = ";"
                         ,na = "NS-NR" )

# Define UI for application that draws a histogram
ui <- fluidPage(    
    
    # Give the page a title
    titlePanel("Apoyo al feminismo en América Latina"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
        
        # Define the sidebar with one input
        sidebarPanel(
            selectInput("q1", "País:", 
                        choices=unique(respu.data$q1)),
            hr(),
            helpText("Seleccione el país. Esta app tiene solo una pequeña muestra 
                     de los datos, por lo que los resultados no son confiables. 
                     Es solo un demo de la app.")
        ),
        
        # Create a spot for the barplot
        mainPanel(
            plotOutput("Plot")  
        )
        
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    

    output$Plot <- renderPlot({
        respu.data <- filter(respu.data, q1 == input$q1)
        plot <- ggplot(na.omit(respu.data), mapping = aes(x = q46))
        titulo <- labs(title = print(input$q1), caption = "Sensata UX Research")
        
        
        plot + geom_bar(color = "#8f4fc1", fill = "#8f4fc1") + titulo +
            ylab("Cantidad de respuestas") +
            scale_x_continuous(name = "Las feministas hacen el mundo...",
                               breaks = c(1,2,3,4,5),
                               labels = c("Peor", "2", "3", "4",  "Mejor")) +
            theme_hc() 
        
        })
}

# Run the application 
shinyApp(ui = ui, server = server)
