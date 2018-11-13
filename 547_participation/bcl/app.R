library(shiny)
bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("BC Liquor price app",
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel("This text is in the sidebar."),
    mainPanel(
      "This text is in the main panel.",
      plotOutput("price_hist"),
      tableOutput('table')
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$price_hist = renderPlot(ggplot2::qplot(bcl$Price))
  output$table = renderTable(bcl)
}

# Run the application
shinyApp(ui = ui, server = server)

