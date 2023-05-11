library(shiny)
library(shiny.semantic)
ui <- semanticPage(
  
  # Agrega una imagen
  tags$img(src='logo.png', 
           align = "right", 
           style = "float:right; margin-left:10px; margin-top:10px; height:50px;"),
  
  # Agrega un título
  titlePanel(strong("Menú interactivo de consulta Zonas metropolitanas")), 
  theme = "sandstone",
  
  # Agrega un layout con sidebar
  sidebar_layout(
    # Agrega un panel principal
    main_panel(
      
      verbatimTextOutput("instrucciones"),
      # Agrega un selector de opciones
      selectInput("opcion", "Seleccione una zona metropolitana:", choices = c("1.01", "2.01", "2.02", "2.03", "3.01", "4.01", "5.04", "5.02", "5.01", "5.03", "6.02", "6.01", "7.02", "7.01", "8.01", "8.02", "8.03", "8.04", "9.01", "10.01", "22.01", "11.01", "11.02", "11.03", "11.04", "16.01", "11.05", "12.01", "12.02", "13.02", "13.03", "13.01", "14.01", "14.02", "14.03", "15.02", "15.01", "16.02", "16.03", "17.01", "17.02", "18.01", "19.01", "20.01", "20.02", "21.01", "21.03", "21.02", "23.01", "23.02", "24.01", "24.02", "25.01", "25.02", "26.01", "26.02", "26.03", "27.01", "28.05", "28.02", "28.03", "28.04", "28.01", "29.01", "30.01", "30.07", "30.03", "30.05", "30.08", "30.06", "30.02", "30.04", "31.01", "32.01"),width = 300),
      
      # Agrega tres botones
      actionButton("tejer2", "Nombres"),
      actionButton("tejer", "Generar reporte"),
      actionButton("abrir_html", "Abrir documento")
    ),
    
    # Agrega un panel lateral
    sidebar_panel (
      p(strong("Instrucciones:")),
      p("1.- Selecciona la clave de alguna zona metropolitana disponible desplegando la lista. En caso de no conocer las claves puede dar clic en el boton de", em('Nombres')),
      p("2.- Da clic en", em('Generar reporte'), "y espere unos segundos a la notificación de que esta listo su documento"), 
      p("3.- Clic en", em('Abrir documento'))),
    
  ),
  
  # Agregar un elemento de texto que muestre el mensaje de reporte creado
  p("", id = "reporte_creado"),
  
  # HTML resultante
  uiOutput("html"),
  uiOutput("html2")
)


server <- function(input, output, session) {
  
  # Ejecuta el código cuando se presiona el botón 1
  output$html <- renderUI({
    req(input$tejer)
    my_params <- list(zona = as.numeric(input$opcion))
    
    # Mostrar barra de progreso mientras se renderiza el reporte
    withProgress(message = "Generando reporte", value = 0, {
      # Renderizar el reporte
      for (i in 1:5) {
        Sys.sleep(1)
        value <- i / 5
        setProgress(value)
      }
      # Renderizar el reporte
      result <- rmarkdown::render("prueba.Rmd", params = my_params)
      showNotification("Reporte creado, presione en 'Abrir documento", 
                       duration = 15, 
                       type = "message",
                       closeButton = FALSE,
                       id = NULL,
                       location = "topRight")
    })
  })
  
  # Ejecuta el código cuando se presiona el botón 2
  # Abre el archivo HTML en una nueva pestaña del navegador
  observeEvent(input$abrir_html, {
    browseURL("prueba.html")
  })
  
  # Teje el archivo R Markdown y muestra el resultado en la página
  output$html2 <- renderUI({
    req(input$tejer2)
    result <- rmarkdown::render("ZM.Rmd")
    showNotification("¡Listo!", 
                     duration = 2, 
                     type = "message",
                     closeButton = FALSE,
                     location = "topRight")
    browseURL("ZM.html")
  })
  
}
shinyApp(ui, server)
