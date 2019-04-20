library(shiny)
library(shinydashboard)
library(DT)
library(openxlsx)
options(shiny.maxRequestSize=500*1024^2) 


shinyServer(function(input, output) {

    output$contents <- renderDT({
        req(input$file1)
        tryCatch({
                df <- read.csv(input$file1$datapath, 
                               sep = input$sep
                               )
            },
            error = function(e) {
                stop(safeError(e))
            }
        )
        if(input$disp == "head") {
            return(head(df))
        }
        else {
            return(df)
        }
    })
    
    output$downloadData <- downloadHandler(
        filename = function(file) {
            paste0("data-", Sys.Date(), ".xlsx")
        },
        content = function(con) {
            write.xlsx(x = read.csv(input$file1$datapath, 
                                sep = input$sep),
                       con, sheetName = "Sheet 1", row.names = FALSE)
        }
    )
})
