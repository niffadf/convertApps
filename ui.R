library(shiny)
library(shinydashboard)
library(DT)
library(openxlsx)
options(shiny.maxRequestSize=500*1024^2) 

dashboardPage(
    dashboardHeader(title = "Converter Apps"),
    dashboardSidebar(
        tags$head(tags$style(HTML('.logo {
                              background-color: #8dc73f !important;
                              }
                              .navbar {
                              background-color: #8dc73f !important;
                              }
                              '))),
        fileInput("file1", "Choose your CSV File:",
                  multiple = FALSE,
                  accept = c("text/csv",
                             "text/comma-separated-values,text/plain",
                             ".csv")),
        radioButtons("sep", "Separator: ",
                     choices = c(Comma = ",",
                                 Semicolon = ";",
                                 Tab = "\t"),
                     selected = ","),
        radioButtons("disp", "Display: ",
                     choices = c(Head = "head",
                                 All = "all"),
                     selected = "head"),
        hr(),
        p("Download your xlsx file:"),
        downloadButton("downloadData",label = "Download")
    ),
    dashboardBody(
        DTOutput("contents")
    )
)
