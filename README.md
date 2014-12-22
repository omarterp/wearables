# Getting And Cleaning Data - Course Project

## Introduction

This repo contains my course project to [Coursera](https://www.coursera.org) ["Getting And Cleaning Data"](https://class.coursera.org/getdata-016) course that is part of [Data Science](https://www.coursera.org/specialization/jhudatascience/1?utm_medium=listingPage) specialization.

There is a single R-script `run_analysis.R`. This script file contains all the functions to accomplish the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set 
   with the average of each variable for each activity and each subject

The `CodeBook.md` provides further detail.

## Assumptions

+ Data is assumed to be extracted from the archive in the working directory.
   * https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Output

+ Output is in the form of a .csv file and is placed in the working directory, named tidy_data_set.txt

