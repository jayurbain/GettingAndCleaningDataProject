# GettingAndCleaningDataProject
=============================

## Getting and Cleaning Data - Course Project

## Required application functionlaity: You should create one R script called run_analysis.R that does the following.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Application flow:
1) Download data, if necessary into a "data" subdirectory of your current working directory
2) Read activities, features, and identify mean and std feature columns
3) Read and prepare test data
4) Read and prepare training data
5) Merge test and training data
6) Write tidy data set to "tidy_data.txt"

## Steps for executing ```run_analysis.R``` to create tidy data set:
1. Place ```run_analysis.R``` into your target working directory.
2) From your R console, set your current working directory using the R ```setwd()``` function.
3. Run ```source("run_analysis.R")```. A new file ```tiny_data.txt``` will be generated in your working directory.

## Dependencies

```run_analysis.R```  will help you to install the dependencies automatically. It depends on ``data.table```. 