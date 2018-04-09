library(dplyr)


if (!exists ("z")){
  dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  temp <- tempfile()
  download.file(dataUrl, temp, mode ="wb")
  z <- unzip(temp)
  unlink(temp)
}

#---Merges the training and the test sets to create one data set.----------
# read relevant data files
train <- read.table(z[27])
test <- read.table(z[15])
feature <-read.table(z[2])
actlabel <- read.table(z[1]) 
activity_train <- read.table(z[28])
activity_test <- read.table(z[16])
subject_train <- read.table(z[26])
subject_test <- read.table(z[14])

# merge test and train data
mergedDF <- rbind(test, train)
collabel <- tolower(as.character(levels(feature$V2))[feature$V2])
colnames(mergedDF)<- collabel

#---Extracts only the measurements on the mean and standard deviation for each measurement. 
resDF <- mergedDF[grep("mean|std", collabel)]
rm(mergedDF)

#activity label
actlabel <- actlabel[,2]
activity <- rbind(activity_test, activity_train)
activity <- as.vector(t(activity))
resDF$activity <- activity
for (i in seq_along(actlabel)) {
  resDF$activity <- gsub(as.character(i),actlabel[i],resDF$activity)
}

rm(activity_train, activity_test)

subject <- rbind(subject_test, subject_train)
subject <- as.vector(t(subject))
resDF$subject <- subject


meanDF <- resDF %>%
  group_by(subject, activity) %>%
  summarize_all(mean)





