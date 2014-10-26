#Step 0. Set working directory
setwd("C:/Users/markmo/SkyDrive/Learning/DataScience/Course3-GettingAndCleaningData")

#Step 1a. Import all required files
  #Test files:
      #Data file
      rawData2 <- read.table("./data/project/UCI HAR Dataset/test/X_test.txt")
      #Activity column
      rawHeader2 <- read.table("./data/project/UCI HAR Dataset/test/y_test.txt")
      #subject column
      rawHeader2b <- read.table("./data/project/UCI HAR Dataset/test/subject_test.txt")
  #Train files
      #Data file
      rawDataTrain <- read.table("./data/project/UCI HAR Dataset/train/X_train.txt")
      #Activity column
      rawDataTrainHeader <- read.table("./data/project/UCI HAR Dataset/train/y_train.txt")
      #subject column
      rawDataTrainHeaderb <- read.table("./data/project/UCI HAR Dataset/train/subject_train.txt") #subject header
  #Column header file
      rawColumnHeader <- read.table("./data/project/UCI HAR Dataset/features.txt")
#Step 1b. Merge files
  #Merge data files with Activity and Subject columns, the combine into one data.frame
      rawTest <- cbind(rawHeader2, rawData2)
      rawTest <- cbind(rawHeader2b, rawTest)
      rawTrain <- cbind(rawDataTrainHeader, rawDataTrain)
      rawTrain <- cbind(rawDataTrainHeaderb, rawTrain)
      rawCombo <- rbind(rawTest, rawTrain)
  #Merge with the column header row
      colHeader <- data.frame(rawColumnHeader[,2])
      colHeader <- t(colHeader)
      names(rawCombo) <- c("Subject","RowLabel", colHeader)

#Step 2. Extract only the mean and standard devation measurements
  #Create vectors to hold a list of the mean and standard deviation columns, then combine into one list
  #of the final column set
      temp <- grep("mean()",rawColumnHeader[,2], fixed=TRUE)+2
      temp3<- grep("std()",rawColumnHeader[,2], fixed=TRUE)+2
      temp4 <- c(1,2,temp, temp3)
      temp5 <- sort(temp4)
  #Extract the mean and std columns into a new data.frame and convert to a tbl_df called slimDataTD
      slimData <- rawCombo[,temp5]
      slimDataTD <- tbl_df(slimData)

#Step 3. Use descriptive names for the Activity rows
      Activities <- c("Walking","WalkingUpstairs","WalkingDownstairs","Sitting","Standing","Laying")
      
      df <- data.frame()
      for(n in 1:nrow(slimData))
      {
            df[n,1] <- Activities[slimData[n,2]]
      }
      
      slimDataTD3 <- cbind(df,slimDataTD)
      slimDataTD3 <-tbl_df(slimDataTD3)
      names(slimDataTD3)[1] <- "Activity"

      #verifying that Activity corresponds to RowLabel
#       group_by(slimDataTD3, Activity)
#       byActivity <- group_by(slimDataTD3, Activity)
#       summarize (byActivity, mean(RowLabel))

      #removes RowLabel column
      slimDataTD3 <- select(slimDataTD3, -RowLabel)
      #slimDataTD3 <- select(slimDataTD3, Subject, Activity, 3:67)

#Step 4. Rename column (variable) headers to more descriptive names
      NewColList <- names(slimDataTD3)

      NewCL <- NewColList#[,2]
      NewCL2 <- gsub("Gyro","Gyroscope",NewCL, fixed=TRUE)
      NewCL2 <- gsub("Acc","Accelerometer",NewCL2, fixed=TRUE)
      NewCL2 <- gsub("std()","StandardDeviation",NewCL2, fixed=TRUE)
      NewCL2 <- gsub("tB", "timeB",NewCL2, fixed=TRUE)
      NewCL2 <- gsub("tG", "timeG",NewCL2, fixed=TRUE)
      NewCL2 <- gsub("fB", "frequencyB",NewCL2, fixed=TRUE)
      NewCL2 <- gsub("mean()", "mean",NewCL2, fixed=TRUE)

      names(slimDataTD3) <- NewCL2

#Step 5. Summarize the tidy data set and output to a file:
      byActivitySubject <- group_by(slimDataTD3, Activity, Subject)
      final <- summarise_each(byActivitySubject, funs(mean))
      #final
      write.table(final, file="SummaryByActivity_Subject.txt", row.names=FALSE)
