library (shiny)
require (shinydashboard)
library(dplyr)
library(ggplot2)

theme_set(theme_bw())
data<-read.csv("2018.csv", stringAsFactor = FALSE, header = TRUE)
year <- (2018)



#define ui 
shinyUI(
  dashboardPage(
    skin = "blue",
    dashboardHeader(title = "Who Is Happy??"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Happiness rate", tabName = "dashboard", icon = icon("calculator")),
        menuItem("Dataset", tabName ="dataset",icon=icon("book")),
        menuItem("Boxplot", tabName = "boxplot", icon = icon("bar-chart-o")),
        menuItem("Comparison of Region", tabName = "compare", icon = icon("line-chart"))
      )
    )
    
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              h1("Who Is Happy??"),
              fluidRow(
                img(src='https://lh3.googleusercontent.com/ApW2Um8gCc3O-isltwjcdALAp-Y5GXXmHVCALmap-Okh4zxWY3nKl1WXJuQ1R1OWL6fK=s170', height = "20%", width = "100%", align = "center"),
                h2("Basic concepts of Happiness"),
                p("Three Surprising Facts About Happiness"),
                p("- Happiness is Contagious. Like a cold, happiness can be caught from the people around you."),
                p("- Smiling actually does make you feel happy. Nothing is more annoying than the stranger that tells you to 'smile'"),
                p("- Emotions last only a few seconds. If you've ever been stuck in a bad mood for days on end, this might sound unlikely."),
                
                box(
                  title = strong("Input Dashborad"), solidHeader = TRUE, collapsible = TRUE, status = "danger",
                  h4(strong("Choose your filter to visualise the data")),
                  htmlOutput("region_selector")
                  
                ),
                
                box(
                  title ="Frequency Graph", solidHeader = TRUE, collapsible = TRUE, status = "danger",
                  h4(strong("Year versus Happiness Rate")),
                  plotOutput("fgraph")
                ),
                
                box(
                  title = "Boxplot", solidHeader = TRUE, collapsible = TRUE, status = "danger",
                  h4(strong("Analysis for the chosen region: ")),
                  
                  textOutput("t1"),
                  textOutput("t2"),
                  textOutput("t3"),
                  textOutput("t4"),
                  textOutput("t5")
                )
    )
  ),
  
  tabItem(tabName = "dataset",
          fluidPage(
            h2 ("Dataset used"),
            p("The dataset that we used is sorced from kaggle.com. Table below represents an interactive visualisation of dataset used"),
            br(),
            sidebarLayout(
              sidebarPanel(
                conditionalPanel(
                  'input.dataset==="data"',
                  helpText("Choose the variable(s) to show"),
                  checkboxGroupInput("show_vars", "Columns in datsets:",
                                     names(data), selected =)
                )
              ),
              mainPanel (
                tabsetPanel(
                  id = 'dataset',
                  tabPanel("data", DT::dataTableOutput("mytable1"))
                )
              )
            ),
          
          tabItem( tabName = "boxplot",
                   fluidPage(
                     h2("Boxplot of the whole dataset "),
                     br(),
                     plotOutput("myplot1")
                   )
          ),
          
          tabItem(tabName = "compare",
                  fluidPage(
                    h2("Comparison of Happiness Rate between region"),
                    br(),
                    sidebarLayout(
                      sidebarPanel (
                        selectInput("coun", "Select a region: ",data[,1])
                      ),
                      mainPanel(
                        plotOutput("comp")
                      )
                    )
                  ))
          )
    ))
)
)
#define server logic
