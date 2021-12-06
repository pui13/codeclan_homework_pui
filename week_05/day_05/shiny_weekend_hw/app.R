library(tidyverse)
library(CodeClanData)
library(shiny)
library(DT)
library(shinyWidgets)



ui <- fluidPage(
  titlePanel("Computer Games"),
  tabsetPanel(
    tabPanel(
      "Top Rated Games",
      fluidRow(
        column(3,
              pickerInput(
                inputId = "platform_input",
                label = "Select Platforms",
                choices = c("Wii", "DS", "3DS",
                            "PS4", "PS3", "X360",
                            "PS2", "PS", "WiiU",
                            "GC", "GBA", "PSP",
                            "PC", "XOne", "XB",
                            "PSV"
                ),
                options = list(`actions-box` = TRUE),
                multiple = TRUE
              )
        ),
        column(3,
               pickerInput(
                 inputId = "genre_input",
                 label = "Select Genres",
                 choices = c("Sports", "Racing", "Platform",
                             "Misc", "Puzzle", "Simulation",
                             "Action", "Shooter", "Fighting",
                             "Adventure", "Role-Playing", "Strategy"
                 ),
                 options = list(`actions-box` = TRUE),
                 multiple = TRUE
               )
        ),
        column(3,
               br(), 
              actionButton("go",
                            "Genereate Table"
              )
        )
      ),
      h5("Sort By :"),
      tabsetPanel(
        tabPanel("Critic Score",
                dataTableOutput("critic_score")
        ),
        tabPanel("User Score",
                 dataTableOutput("user_score")
        )
      )
    ),
    tabPanel(
      "Score Distribution",
      sidebarLayout(
        sidebarPanel(
          sliderInput("bins_input",
                      "Number of bins",
                      min = 10,
                      max = 50,
                      value = 30)
        ),
        mainPanel(
          plotOutput("score_histo")
        )
      )
    )
  )
)

server <- function(input, output, session) {
  filtered_data <- eventReactive(input$go, {
    game_sales %>%
      filter( platform %in% input$platform_input,
              genre %in% input$genre_input) %>%
      select(name, platform, critic_score, user_score) %>%
      rename("Game" = name,
             "Platform" = platform)
  })
  
  output$user_score <- renderDataTable({
    filtered_data() %>%
      arrange(desc(user_score))
    })
  output$critic_score <- renderDataTable({
    filtered_data() %>%
      arrange(desc(critic_score))
  })
  
  output$score_histo <- renderPlot({
    game_sales %>%
      ggplot(aes(user_score)) +
      geom_histogram(bins = input$bins_input)
  })
}

shinyApp(ui, server)



# radioButtons("sort_input",
#              "Sort by",
#              choices = list("Critic Score" = critic_score,
#                             "User Score" = user_score)
# )