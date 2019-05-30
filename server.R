library (shiny)
require (shinydashboard)
library(dplyr)
library(ggplot2)
theme_set(theme_bw())
data<-read.csv("2018.csv", stringAsFactor = FALSE, header = TRUE)
year <- (2018)


#define server logic

shinyServer(function(input, output) {
  output$data_selector <- renderUI ({
    radioButtons("rd"
                 label = "Select region: ",
                 choices = list ("Southern Asia" = 0,"Central and Eastern Europe" = 1,"North America" = 2,"Southeastern Asia" = 3,"Western Europe" = 4,"Australia and New Zealand" = 5,"Eastern Asia" = 6,"Sub-Saharan Africa" = 7),
                 selected = 0
                 )  # Create the choices that can be selected. e.g. Display "A" and link to value "a"))
  })
  output$country_selector <- renderUI ({
    check <- input$rd
    if(check==0){
      selectInput("name", "Country Name:", data[1])
    }
  })
  
  #choose columns to display
  data2 = data[sample(nrow(data), 9, replace = FALSE, prob = NULL),
               ]
               output$mytable1 <- DT ::renderDataTable({
                 DT::datatable(data2[, input$input_vars, drop = FALSE])
               })
               
               #plot the frequency graph
               output$fgraph <- renderPlot ({
                 #to check region
                 radio <- input$rd
                 #to search frequency of specific region
                 q <- input$region
                 #qw is to append the data of the region later
                 qw <- c()
                 if(radio==1){
                   for(i in 1 : nrow(data)) {
                     if(q==data[i,1]){
                       for(j in 1:ncol(data)){
                         if(j>2){
                           qw <- c(qw, data[i,j])
                         }
                       }
                     }
                   }
                     year <- (2018)
                 }
                 
                rate <- as.integer(qw)
                d <- data.frame(year,rate)
                ggplot(d,aes(x= year, y=rate))+geom_smooth(fill = "#0073C2EF", stat = "identity")+xlab("year")+ylab("happiness rank")
                 
               })
               
               output$myplot <- renderPlot({
                 c <- input$region
                 qw <- c()
                 if(radio==1){
                   for(i in 1:nrow(data)){
                     if(c==data[i,1]){
                       for(j in 1:ncol(data)){
                         if(j>2){
                           qw < c(qw, data[i,j])
                         }
                       }
                     }
                   }
                   year <- (2018)
                 }
                 rate <- as.integer(qw)
                 d <- data.frame (year, rate)
                 boxplot(d[,2],
                         xlab = 'year',
                         ylab = 'percentage of happiness'
                 )
                 
               })
               
               da <- reactivr({
                 radio <- input$rd
                 c <- input$region
                 qw <- c()
                 if (radio==1){
                   for(i in 1: nrow(data)){
                     if(c==data[i,1]){
                       for (i in 1: ncol(data)){
                         if(j>2){
                           qw <- c(qw, data[i,j])
                         }
                       }
                     }
                   }
                   year <-(2018)
                 }
                 rate <- as.integer(qw)
                 d <- data.frame(year, rate)
                 return(d)
               })
               
               output$t1 <- renderText({
                 a <- da()
                 paste("Mean               : ", mean(a[,2]))
               })
               
               output$t2 <- renderText({
                 a <- da()
                 paste("Medain             : ", median(a[,2]))
               })
               
               output$t3 <- renderText({
                 a <- da()
                 paste("Standard Deviation : ", sd,(a[,2]))
               })
               
               output$t4 <- renderText({
                 a <- da()
                 paste("Min                : ", min(a[,2]))
               })
               
               output$t5 <- renderText({
                 a <- da()
                 paste("Max. Value         : ", max(2[,2]))
               })
               
               output$myplot1 <- renderPlot({
                 boxplot(data[,3:30],
                         xlab = 'year',
                         ylab = 'percentage of happiness')
               })
               
               output$comp <- renderPlot({
                 c <- input$coun
                 f <- c()
                 for(i in 1 :nrow(data)){
                   if(c==data[i,1]){
                     for(j in 1:ncol(data)){
                       if(j>2){
                         f <- c(f,data[i,j])
                       }
                     }
                   }
                 }
                yr <- (2018)
                value <-(f)
                year <- (yr)
                df <- data.frame(year,value)
                ggplot(df,aes(x=year, y=value, group = region, color = region))+geom_point()+geom_line()+scale_color_manual(labels = c("region"), values = c("region"="red"))+theme(axis.text.x = element_text(angle = 90, vjust=0.5,size=8),panel.grid.blank())
               })
})
