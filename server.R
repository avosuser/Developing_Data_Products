library(data.table)
library(caret)
library(randomForest)

hddata <- data.table(read.csv("data/heartdiseasedata.csv", header = TRUE, sep = ","))

setnames(hddata, c("age","sex","cp","trestbps","chol","fbs","restecg","thalach","exang",
                   "oldpeak","slope","ca","thal","heartdisease") )

# Cleanup missing data
hddata <- hddata[!ca %in% c("?")]
hddata <- hddata[!thal %in% c("?")]

hddata$ca <- as.numeric(as.character(hddata$ca))
hddata$thal <- as.numeric(as.character(hddata$thal))
hddata$heartdisease <- as.numeric(as.character(hddata$heartdisease))

hddata[heartdisease == 2, heartdisease := 1]
hddata[heartdisease == 3, heartdisease := 1]
hddata[heartdisease == 4, heartdisease := 1]

hddata$heartdisease <- factor(hddata$heartdisease, labels = c("absent", "present"))
hddata <- data.frame(hddata)

inTrain <- createDataPartition(y = hddata$heartdisease, p = 0.98, list = FALSE)
training <- hddata[inTrain ,]
validation <- hddata[-inTrain ,]
rownames(validation) <- 1:nrow(validation)
validation1 <- subset(validation, select = -heartdisease)

#set.seed(779)
rf <- randomForest(heartdisease ~ ., data = training, importance = T, proximity = T)
#rf <- randomForest(heartdisease ~ ., data = training)

shinyServer(
  function(input, output) {
      output$val <- renderTable({validation})
      output$val1 <- renderTable({validation1})
      output$hd <- renderTable({
              tmptbl <- validation1[input$radio,]
              tmptbl$heartdisease <- predict(rf, tmptbl)
              tmptbl
      })
      
      output$rndfor <- renderPrint({
        rf
      })
      
      output$plot1 <- renderPlot({
              plot(rf)
      })
      
      output$varImpPlot <- renderPlot({
        varImpPlot(rf)
      })
      
      
  }
)