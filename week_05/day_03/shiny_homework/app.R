
library(shiny)
library(tidyverse)
library(CodeClanData)
library(shinythemes)



ui <- fluidPage(
  theme = shinytheme("darkly"),

    titlePanel(tags$i(h1("Inflation", align = "center"))),
    sidebarLayout(
        sidebarPanel(
            radioButtons("country_input",
                        tags$b("Which Country?"),
                        choices = c("UK",
                                    "France",
                                    "Germany",
                                    "Spain")
            ),
            
        ),
        mainPanel(
           plotOutput("inflation_plot")
        )
    ),
  img(src="arrow.gif", align = "left",height='250px',width='350px'),
  img(src="wallstreet.gif", align = "right",height='250px',width='450px')
)
server <- function(input, output) {

    output$inflation_plot <- renderPlot({
      inflation4 %>%
        filter( variable == input$country_input) %>%
        ggplot(aes(Year, value, colour = variable)) +
        geom_line() +
        geom_point() +
        theme_linedraw() +
        labs( y = "Inflation %",
              title = "Inflation Rate Over Time")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
