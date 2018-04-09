---
title: "CodeBook"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


This is an R Markdown document. This code book will describe the data used in this project, as well as the processing required to create the resulting tidy data set.

# Overview

30 volunteers performed 6 different activities while wearing a smartphone. The smartphone captured various data about their movements


# Input 

Assigned Name | File               | Description               | Type after read in (DF = data frame)
--------------|--------------------|---------------------------|----------------------------------------
feature       | features.txt       | Names of the 561 features | DF 561 obs. of 2 variables
actlabel      | activity_labels.txt| Names and IDs for each of the 6 activities|Factor, Levels: LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
train         | X_train.txt        |obs. for 21 of the 30 volunteers| DF 7352 obs. of the 561 features 
test          | X_test.txt  |obs. for  9 of the 30 volunteers| DF 2947 obs. of the 561 features
subject_train  |subject_train.txt| denoting the ID of the volunteer related to each of the observations in X_train.txt | DF 7352 obs. of 1 variable
subject_test  |subject_test.txt| denoting the ID of the volunteer related to each of the observations in X_test.txt | DF 2947 obs. of 1 variable
activity_train  |y_train.txt| denoting the ID of the activity related to each of the observations in X_train.txt | DF 7352 obs. of 1 variable
activity_test  |activity_test.txt| denoting the ID of the activity related to each of the observations in X_test.txt | DF 2947 obs. of 1 variable

More information about the files is available in README.txt. More information about the features is available in features_info.txt.

## Data files that were not used

This analysis was performed using only the files above, and did not use the raw signal data. Therefore, the data files in the "Inertial Signals" folders were ignored.

## Processing steps

###A Combining and Extracting

1.    Data set was downloaded from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  Zip file was stored in a temporary file called "temp" for unzipping.
* z : a character vector containing full path names of text files from the data set

2. All of the relevant data files were read into data frames.See Input for assigned names.

3. Test and training data were merged together to one data set. Appropriate column headers were added.
 ```{r}mergedDF <- rbind(test, train)
collabel <- tolower(as.character(levels(feature$V2))[feature$V2])
colnames(mergedDF)<- collabel```

+ mergedDF : data frame with 10299 obs. of 561 variables
+ collabel : character vector containing features, extracted from feature data frame and converted from factor to character

4. All feature columns were removed that did not contain the exact string "mean" or "std". This left 86 feature colums. 
```{r}resDF <- mergedDF[grep("mean|std", collabel)]```

5. Activity column was added

+ activity_test and activity_train were merged together and assigned to a variable called activity
```{r}activity <- rbind(activity_test, activity_train)```

+ activity was converted from data frame to vector
```{r}activity <- as.vector(t(activity))```

+ and added as new colum resDF$activity
```{r}resDF$activity <- activity```

+ following code block replaces the activity ID with the corresponding activity label

```{r}for (i in seq_along(actlabel)) {
  resDF$activity <- gsub(as.character(i),actlabel[i],resDF$activity)
}```

6. Subject ID column was added respectively

### B Creation of a tidy data set

A tidy data set was created containing the mean of each feature for each subject and each activity. 
Since there are 30 subjects and 6 activity labels resulting data frame has a total of 180 rows. Each row contains the mean value for each of the 86 features for that subject/activity combination. 

    
```{r}meanDF <- resDF %>%
  group_by(activity, subject) %>%
  summarize_all(mean)```


The tidy data set was written as csv file and stored in working directory

```{r}write.csv(meanDF, file = "analysis_tidy.csv")```












