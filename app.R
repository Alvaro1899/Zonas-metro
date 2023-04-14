library(shiny)

# Define la interfaz de usuario (UI)
ui <- fluidPage(
  
  # Selección de opciones
  selectInput("opcion", "Seleccione una zona metropolitana:", choices = c("1.01", "2.01", "2.02", "2.03", "3.01", "4.01", "5.04", "5.02", "5.01", "5.03", "6.02", "6.01", "7.02", "7.01", "8.01", "8.02", "8.03", "8.04", "9.01", "10.01", "22.01", "11.01", "11.02", "11.03", "11.04", "16.01", "11.05", "12.01", "12.02", "13.02", "13.03", "13.01", "14.01", "14.02", "14.03", "15.02", "15.01", "16.02", "16.03", "17.01", "17.02", "18.01", "19.01", "20.01", "20.02", "21.01", "21.03", "21.02", "23.01", "23.02", "24.01", "24.02", "25.01", "25.02", "26.01", "26.02", "26.03", "27.01", "28.05", "28.02", "28.03", "28.04", "28.01", "29.01", "30.01", "30.07", "30.03", "30.05", "30.08", "30.06", "30.02", "30.04", "31.01", "32.01")),
 
  # Botón para tejer el archivo R Markdown
  actionButton("tejer2", "Zonas metropolitanas disponibles"),
  
   # Botón para tejer el archivo R Markdown
  actionButton("tejer", "Mostrar reporte de la zona metropolitana"),
 
   # Botón para abrir el archivo HTML
  actionButton("abrir_html", "Mostrar reporte de la zona metropolitana en Chrome"),
  

 
   # HTML resultante
  uiOutput("html")
)

# Define la lógica del servidor
server <- function(input, output) {
  
  # Teje el archivo R Markdown "prueba.RMD" y muestra el resultado en la página
  output$html <- renderUI({
    req(input$tejer)
    result <- rmarkdown::render("prueba.Rmd", params = my_params)
    includeHTML(result)
  })
  # Abre el archivo HTML en una nueva pestaña del navegador
  observeEvent(input$abrir_html, {
    browseURL("prueba.html")
  })
  # Teje el archivo R Markdown y muestra el resultado en la página
  output$html <- renderUI({
    req(input$tejer2)
    result <- rmarkdown::render("ZM.Rmd")
    includeHTML(result)
  })
}

# Ejecuta la aplicación
shinyApp(ui, server)
