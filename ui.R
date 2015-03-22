library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("spacelab"),
  titlePanel(
    tags$hr(h1("Heart Disease Prediction", align = "center")),
  ),
  
  sidebarLayout(
    sidebarPanel(
      h3("Program Description", align = "left"),
      p("This purpose of the program is to demonstrate the Random Forest algorithm using the 'Heart Disease' data set obtained from the UCI machine learning repository."),
      tags$a(href="https://archive.ics.uci.edu/ml/datasets/Heart+Disease", "UCI Machine Learning"),
      p("This program is intutive to understand, however the 'Documentation' tab has more details on code and usage guidelines")
      ),
      
    mainPanel(
      tabsetPanel(
        tabPanel("Prediction",
          p("Training Data set: Extracted 5 Row Validation Data Set using createDataPartition func"),
          tableOutput("val"),
          p("Validation Data set: Intentionally dropped the 'heartdisease' column from the Training data set"),
          tableOutput("val1"),
      
          radioButtons("radio", 
          label = p("Select row number from the Validation Data set"), 
          choices = list(
                      "Row 1" = 1, 
                      "Row 2" = 2, 
                      "Row 3" = 3,
                      "Row 4" = 4,
                      "Row 5" = 5), inline = TRUE),
      
          tableOutput("hd")
        ),
        tabPanel("Random Forest",
          h3("Random Forest Summary"),
          br(),
          verbatimTextOutput("rndfor"),
          plotOutput("plot1"),
          plotOutput("varImpPlot")
        ),
        tabPanel("Documentation",
          br(),
          h4("ui.R & server.R"),
          p("The code is located on Github @"),
          tags$a(href="https://github.com/avosuser/Developing_Data_Products", "Github Repository"),
          h4("Data Set used for this Program "),
          p("The Heart Disease Data Set was obtained form the UCI Machine Learning Repository, for this Shiny App I am using the processsed.cleveland.data set.The data set consists of 14 variables, the 14th variable is a number from 0 to 4,
        with 0 meaning no presence of heart disease and 1 thru 4 representing presense of heart disease"),
          h4("Data Cleaning"),
          tags$ol(
            tags$li("Added Column Names."),
                  tags$li("Converted few variables to numeric."),
                  tags$li("Changed the 14th column 'heartdisease' to binary values i.e. changed 1,2,3 or 4 to a 1."),
                  tags$li("Created a training set and a very small 5 row validation set using the createDataPartition() function.")
          ),
          h4("How the program functions and usage", align = "left"),
          h6("Pseudo Code", align = "left"),
          tags$ul(
            tags$li("Random Forest is run using the training data set"),
            tags$li("The 5 row validation data set is displayed as is."),
            tags$li("For demoonstration purposes, I have intentionally drop the 'heardisease' column from the validation data set and display it"),
            tags$li("When the user select a radiobutton, using the selected index number a temprorary one row data frame is created."),
            tags$li("The predict() function of random forest is run with the temprorary one row data frame as the argument"),
            tags$li("The predicted value is then added back as a new 'heartdisease' column to the one row data frame."),
            tags$li("The one row data frame with all 14 variables is displayed"),
            tags$li("Random Forest tab outputs the confusion matrix, error rate and varImpPlot graphs")
          ),
          h6("Usage", align = "left"),
          tags$ul(
            tags$li("Select a radio button and the predicted value is dynamically displayed"),
            tags$li("P.S. randon forest is comming up with ~20% error rate, so you should see on an average 1 out of the 5 predictions incorrect"),
            tags$li("Select the Ramdom Forest tab to get key output from the algorithm 'the shiny server is slow so it will take a while for the graphs to be displayed'")
          )
        )
      )              
    )
  )
))
