library(shiny)
library(shinydashboard)
library(rmarkdown)

selectInput(inputId = "zona",
            label = "Seleccione una zona:",
            choices = c("1.01", "2.01", "2.02", "2.03", "3.01", "4.01", "5.04", "5.02", "5.01", "5.03", "6.02", "6.01", "7.02", "7.01", "8.01", "8.02", "8.03", "8.04", "9.01"),
            selected = "1.01")

ui <- dashboardPage(
  dashboardHeader(title = "Mi aplicación Shiny"),
  dashboardSidebar(
    selectInput(inputId = "zona",
                label = "Seleccione una zona:",
                choices = c("1.01", "2.01", "2.02", "2.03", "3.01", "4.01", "5.04", "5.02", "5.01", "5.03", "6.02", "6.01", "7.02", "7.01", "8.01", "8.02", "8.03", "8.04", "9.01"),
                selected = "1.01")
  ),
  dashboardBody(
    fluidRow(
      box(
        title = "Resultado",
        status = "primary",
        solidHeader = TRUE,
        collapsible = TRUE,
        shiny::uiOutput("resultado")  # Se utiliza uiOutput en lugar de htmlOutput
      )
    )
  )
)

server <- function(input, output, session) {
  
  # Define la ruta del archivo RMD
  ruta_rmd <- "prueba.Rmd"
  
  # Genera el resultado a través de la función "render"
  output$resultado <- renderUI({
    # Define los parámetros de la RMD
    params <- list(zona = input$zona)
    # Renderiza la RMD
    result <- markdown::render(ruta_rmd, params = params, envir = new.env())
    includeHTML(result)
  })
  
}

shinyApp(ui, server)

