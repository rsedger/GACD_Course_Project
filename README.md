# Getting and Cleaning Data Course Project

An R script called run_analysis.R has been created. This does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts the measurements on the mean and standard deviation for each measurement.
3. Adds descriptive activity names to name the activities in the data set
4. Labels the data set with the descriptive activity names.
5. Creates an independent tidy data set with the average of each variable for each activity and each subject.

## Steps to recreate this course project

1. Download the data source and unzip into a folder on your local drive. This creates a ```UCI HAR Dataset``` folder.
2. Put ```run_analysis.R``` in the parent folder of ```UCI HAR Dataset```, then set the parent directory as your working directory using ```setwd()``` function in RStudio or R.
3. Run ```source("run_analysis.R")```, this will generate a new file ```tiny_data.txt``` in your working directory.

## Dependencies

```run_analysis.R``` depends on the ```reshape2``` and ```data.table``` R packages. You will need to install them if you don't already have them.
