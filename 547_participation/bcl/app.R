library(shiny)
library(tidyverse)


# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("BC Liquor price app",
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel("This text is in the sidebar.",
                 sliderInput("priceInput", "Select your desired price range.",
                             min = 0, max = 100, value = c(15, 30), pre="$"),
                 radioButtons("typeInput", "Choose your beverage type", c("BEER", "REFRESHMENT", "SPIRITS", "WINE"))
                 ),
    mainPanel(
#      "This text is in the main panel.",
      plotOutput("price_hist"),
      tableOutput('table')
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
#  renderPrint({input$priceInput})

  bcl_show = reactive({filter(bcl,Price>=input$priceInput[1],Price<=input$priceInput[2], Type %in% input$typeInput)})

  output$price_hist = renderPlot(ggplot2::qplot(bcl_show()$Price))
  output$table = renderTable(bcl_show())
}

# Run the application
shinyApp(ui = ui, server = server)

