# Getting and cleaning data - Course Project 


## Introduction
This repository was created for the course project of the Coursera Getting and Cleaning Data course. 

## Task
You should create one R script called **run_analysis.R** that does the following:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## How to use this implementation of run_analysis.R

1. Download the [raw dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Unzip the raw data set to a folder named "UCI HAR Dataset" in your working directory
3. Install the package "dplyr" if not already installed
4. Source the script by source("run_analysis.R")
5. You will find 3 data frames in your environment

The data frame "data" is a tidy dataset with all variables from the raw data.

The data frame "data_mean_std" is a tidy dataset with the mean() and std() variables of the dataset "data".

The data frame "averaged_data_mean_std" is a tidy dataset with the means of each variable in "data_mean_std" for each combination of subject and activity. This data set was additinally exported with the function "write.table" as "averaged_data_mean_std.txt"to your working directory.

## What run_analysis.R does

1. Read raw data
2. Add descriptive variable names
3. Merge data
4. Extratc mean() and std() variables
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

## Dependencies
* Package: dplyr