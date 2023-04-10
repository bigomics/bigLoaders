# bigLoaders
 
The bigLoaders package, property of BigOmics Analytics SA, provides a simple way to add custom loading spinners to Shiny apps. It has been designed to work in synchrony with the [omicsplayground](https://github.com/bigomics/omicsplayground) `PlotModule` structure.

## Installation

You can install the bigLoaders package from GitHub using the devtools package:

```
# install.packages("devtools")
devtools::install_github("your_username/bigLoaders")
```

## Usage

To use the bigLoaders package, simply add the useSpinner() function to your Shiny app's ui function to add a spinner to any Shiny output object:

```
library(shiny)
library(bigLoaders)

ui <- fluidPage(
  addBigLoaderDeps(),
  titlePanel("Custom Loading Spinner with bigLoaders Package"),
  sidebarLayout(
    sidebarPanel(
      actionButton("run", "Run computation")
    ),
    mainPanel(
      div(
        style = "height: 400px",
        useSpinner(plotOutput("myplot", width = "100%", height = "400px"))
      )
    )
  )
)

server <- function(input, output, session) {
  output$myplot <- renderPlot({
    req(input$run)
    Sys.sleep(2) # Simulate a long computation
    hist(rnorm(1000))
  })
}

shinyApp(ui, server)

```

## Customization

You can customize the appearance of the loading spinner by editing the CSS styles in the spinner.css file in the inst/www directory of the bigLoaders package.

## Acknowledgements

This package was inspired by the [shinycssloaders]() package by [Dean Attali](https://deanattali.com/).
