# Getting-and-cleaning-data

## Getting and Cleaning Data - Course Project Assignment

This repository contains one R code routine and documentation files for the Data Science's coursera course "Getting and Cleaning data".

PURPOSE
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 

ASSIGNMENT
    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement.
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names.
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

DATASET
    Human Activity Recognition Using Smartphones
    The data set can be received under "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip". 
    For more information on the data set, see provided README file.  

REVIEW CRITERIA
    For the assignment following steps were implemented to receive a tidy data set:
    The submitted data set is tidy.
    The Github repo contains the required scripts.
    GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
    The README that explains the analysis files is clear and understandable.
    The work submitted for this project is the work of the student who submitted it.

ANALYSIS FILES
   CodeBook.md describes the input variables, the data, and the process steps including any transformations to clean up the data.

   run_analysis.R contains all the code to perform the analyses described in ASSIGNMENT. 

   Tidy data set is created in 5th step output data  by a grouping and averaging (see codeBook for details). The resulting data frame is
   written to a csv file called analysis_tidy.csv.