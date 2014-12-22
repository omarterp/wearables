# Code Book

This document describes the code inside `run_analysis.R` and provides a brief overview of 
the variables contained in the output.

## Variables

* `subject_id`                  `activity`
* `tBodyAcc-mean()-X`           `tBodyAcc-mean()-Y`           `tBodyAcc-mean()-Z`           `tBodyAcc-std()-X`           
* `tBodyAcc-std()-Y`            `tBodyAcc-std()-Z`            `tGravityAcc-mean()-X`        `tGravityAcc-mean()-Y`       
* `tGravityAcc-mean()-Z`        `tGravityAcc-std()-X`         `tGravityAcc-std()-Y`         `tGravityAcc-std()-Z`        
* `tBodyAccJerk-mean()-X`       `tBodyAccJerk-mean()-Y`       `tBodyAccJerk-mean()-Z`       `tBodyAccJerk-std()-X`       
* `tBodyAccJerk-std()-Y`        `tBodyAccJerk-std()-Z`        `tBodyGyro-mean()-X`          `tBodyGyro-mean()-Y`         
* `tBodyGyro-mean()-Z`          `tBodyGyro-std()-X`           `tBodyGyro-std()-Y`           `tBodyGyro-std()-Z`          
* `tBodyGyroJerk-mean()-X`      `tBodyGyroJerk-mean()-Y`      `tBodyGyroJerk-mean()-Z`      `tBodyGyroJerk-std()-X`      
* `tBodyGyroJerk-std()-Y`       `tBodyGyroJerk-std()-Z`       `tBodyAccMag-mean()`          `tBodyAccMag-std()`          
* `tGravityAccMag-mean()`       `tGravityAccMag-std()`        `tBodyAccJerkMag-mean()`      `tBodyAccJerkMag-std()`      
* `tBodyGyroMag-mean()`         `tBodyGyroMag-std()`          `tBodyGyroJerkMag-mean()`     `tBodyGyroJerkMag-std()`     
* `fBodyAcc-mean()-X`           `fBodyAcc-mean()-Y`           `fBodyAcc-mean()-Z`           `fBodyAcc-std()-X`           
* `fBodyAcc-std()-Y`            `fBodyAcc-std()-Z`            `fBodyAccJerk-mean()-X`       `fBodyAccJerk-mean()-Y`      
* `fBodyAccJerk-mean()-Z`       `fBodyAccJerk-std()-X`        `fBodyAccJerk-std()-Y`        `fBodyAccJerk-std()-Z`       
* `fBodyGyro-mean()-X`          `fBodyGyro-mean()-Y`          `fBodyGyro-mean()-Z`          `fBodyGyro-std()-X`          
* `fBodyGyro-std()-Y`           `fBodyGyro-std()-Z`           `fBodyAccMag-mean()`          `fBodyAccMag-std()`          
* `fBodyBodyAccJerkMag-mean()`  `fBodyBodyAccJerkMag-std()`   `fBodyBodyGyroMag-mean()`     `fBodyBodyGyroMag-std()`     
* `fBodyBodyGyroJerkMag-mean()` `fBodyBodyGyroJerkMag-std()` 

* The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals 
  tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

* Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk 
  signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

* Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, 
  fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

* These signals were used to estimate variables of the feature vector for each pattern:  
  '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

+ The set of variables that were estimated from these signals are: 
  * mean(): Mean value
  * std(): Standard deviation

* Notes used from Case Study conducted by [Smartlab - Non Linear Complex Systems Laboratory](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Code Details

+ I did not constrain myself by following the project steps in order - see the 1-5 from the ReadMe.md.  I took the approach of 
  generalizing the import process, since this could be reused for other projects.  I am moving in that direction to ensure
  my work is continuously crafting functions that can be reused and more focus can be put towards analysis.
  
__Psuedocode__

- Import data and assign data frames to be used to drive the final product - a tidy data set
- Create a subset of features that we are after - std() and mean() - chose to exclude any mean reference frequency(freq)
- Create new data set with the subset of features - std() and mean()
- Name columns based on featuresSubset$features
- Name rows with activity lable to represent observation in a more meaningful way
- Name columns based on featuresSubset$features
- Add observationIndex to subject, training, test and activity data sets to facilitate data merging
- Add activity label to training and test data sets
- Merge subject and training data sets; drop observation index
- Combine training and test data sets; Detail to be summarized
- Calculate the mean by subject and activty
- Output tidy data set


