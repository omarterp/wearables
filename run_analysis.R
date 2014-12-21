

run_analysis <- function( directory=getwd() ) {

  # Import data and assign data frames to be used to drive the final product - a tidy data set
  rawDataFrames <- importData( prepFileImports( directory ) )
  
  features <- rawDataFrames[[ "features" ]]
  activityLabels <- rawDataFrames[[ "activity_labels" ]]
  
  subjectTrain <- rawDataFrames[[ "subject_train" ]]
  xTrain <- rawDataFrames[[ "X_train" ]]
  yTrain <- rawDataFrames[[ "y_train" ]]

  subjectTest <- rawDataFrames[[ "subject_test" ]]
  xTest <- rawDataFrames[[ "X_test" ]]
  yTest <- rawDataFrames[[ "y_test" ]]
  
  #print( which( with( features, grepl( "std()", feature ) | grepl("mean()", feature) ) ) )
  
  # Create a subset of features that we are after - std() and mean() - chose to exclude any mean reference frequency(freq)
  featuresSubset <- features[which( with( features, grepl( "std[\\(\\)]", feature ) | grepl("mean[\\(\\)]", feature) ) ), ]

  # Create new data set with the subset of features - std() and mean()
  xTrainSubset <- xTrain[, featuresSubset$feature_id ] # Feature Observations
  # Name columns based on featuresSubset$features
  names(xTrainSubset) <- featuresSubset$feature
  # Name rows with activity lable to represent observation in a more meaningful way
  
  xTestSubset <- xTest[, featuresSubset$feature_id ] # Feature Observations
  # Name columns based on featuresSubset$features
  names(xTestSubset) <- featuresSubset$feature
  
  
  # Add observationIndex to subject, training, test and activity data sets to facilitate data merging
  subjectTrain$observation_index <- as.numeric( rownames( subjectTrain) )
  xTrainSubset$observation_index <- as.numeric( rownames( xTrainSubset) )
  yTrain$observation_index <- as.numeric( rownames( yTrain) )

  subjectTest$observation_index <- as.numeric( rownames( subjectTest ) )
  xTestSubset$observation_index <- as.numeric( rownames( xTest ) )
  yTest$observation_index <- as.numeric( rownames( yTest ) )
  
  # Add activity label to training and test data sets
  subjectTrain$activity_label <- activityLabels[ yTrain$activity_id, "activity_label" ]
  subjectTest$activity_label <- activityLabels[ yTest$activity_id, "activity_label" ]
  
  # Merge subject and training data sets; drop observation index
  xTrainBuild <- merge( subjectTrain, xTrainSubset, by.x = "observation_index", by.y = "observation_index" )
  xTrainBuild <- xTrainBuild[, !( names( xTrainBuild ) == "observation_index" ) ]
  
  xTestBuild <- merge( subjectTest, xTestSubset, by.x = "observation_index", by.y = "observation_index" )
  xTestBuild <- xTestBuild[, !( names( xTestBuild ) == "observation_index" ) ]
  
  # Combine training and test data sets; Detail to be summarized
  tidyDataSetDetail <- rbind( xTrainBuild, xTestBuild )
  
  
  
  # Calculate the mean by subject and activty
  tidyDataSetSummary <- aggregate( tidyDataSetDetail[, featuresSubset$feature ], 
                                   list( tidyDataSetDetail$subject_id, 
                                         tidyDataSetDetail$activity_label ), 
                                   mean )
  
  colnames( tidyDataSetSummary ) <- c( "subject_id", "activity", featuresSubset$feature )
  
  # Output tidy data set
  write.table( tidyDataSetSummary, file = "tidy_data_set.txt", row.names = FALSE, sep = "," )

}

getFileRefs <- function() {
  
  # constants to reference data files
  # Referenced as fileRefs in list that drives file imports
  FEATURES <- "features"
  ACTIVTY_LABELS <- "activity_labels"
  
  SUBJECT_TRAIN <- "subject_train"
  X_TRAIN <- "X_train"
  Y_TRAIN <- "y_train"
  
  SUBJECT_TEST <- "subject_test"
  X_TEST <- "X_test"
  Y_TEST <- "y_test"
  
  fileRefs <- c( FEATURES, ACTIVTY_LABELS,
                 SUBJECT_TRAIN, X_TRAIN, Y_TRAIN,
                 SUBJECT_TEST, X_TEST, Y_TEST)
  
  names(fileRefs) <- c( FEATURES, ACTIVTY_LABELS,
                        SUBJECT_TRAIN, X_TRAIN, Y_TRAIN,
                        SUBJECT_TEST, X_TEST, Y_TEST)
  
  fileRefs
  
}

# Create file paths object to be used to load files
prepFileImports <- function( directory ) {
  
  fileRefs <- getFileRefs()
  
  # vector of filePaths for file import
  # Referenced as filePaths in list that drives file imports
  filePaths = c( paste( directory,"/",
                     c( "features.txt", 
                        "activity_labels.txt",
                        
                        "/train/subject_train.txt",
                        "/train/X_train.txt",
                        "/train/y_train.txt",
                        
                        "/test/subject_test.txt",
                        "/test/X_test.txt",
                        "/test/y_test.txt" ), sep = "" ) )
  
  # Name vector members to allow easy reference when importing
  names( filePaths ) <- names( fileRefs )
  
  fileColNames <- list(
    
    # features.txt
    c( "feature_id", "feature" ),
    # activity_lables.txt
    c( "activity_id", "activity_label" ),
    #subject_train
    c( "subject_id" ),
    #x_train
    c( NULL ),
    #y_train
    c( "activity_id" ),
    #subject_test
    c( "subject_id" ),
    #x_test
    c( NULL ),
    #y_test
    c( "activity_id" )
    
  )
  
  # Assign fileRefs
  names( fileColNames ) <- names( fileRefs )
  
  fileColClasses <- list(
    
    # features.txt
    c( "numeric", "character" ),
    # activity_lables.txt
    c( "numeric", "character" ),
    #subject_train
    c( "numeric" ),
    #x_train
    c( rep( "numeric", 561 ) ),
    #y_train
    c( "numeric" ),
    #subject_test
    c( "numeric" ),
    #x_test
    c( rep( "numeric", 561 ) ),
    #y_test 
    c( "numeric" )
    
  )
  
  # Assign fileRefs
  names( fileColClasses ) <- names( fileRefs )
  
  # Populate list that will drive the file import
  fileImportDriver <- list( fileRefs, filePaths, fileColNames, fileColClasses )
  
  names( fileImportDriver ) <- c( "fileRefs" , "filePaths", "fileColNames", "fileColClasses" )
  
  fileImportDriver
  
}

# Load file and return a data frame
loadFile <- function ( filePath, fileColClasses ) {

  dataF <- read.table(filePath,
                      colClasses = fileColClasses,
                      na.strings = c(""),
                      blank.lines.skip = T )
  
  dataF

}

# Load file and return a data frame
importData <- function ( importProps ) {
  
  # Apply the file references to the data frames list
  fileRefs <- getFileRefs()
  
  # List of data frames will hold all imported files
  dataFrames <- vector( 'list', length( fileRefs ) )
  names(dataFrames) <- fileRefs
  
  for( i in fileRefs ) {
    
    filePath <- importProps[[ "filePaths" ]][[i]]
    fileColNames <- importProps[[ "fileColNames" ]][[i]]
    fileColClasses <- importProps[[ "fileColClasses" ]][[i]]
    
    
    dataFrame <- loadFile( filePath, fileColClasses )
    
    # name columns, if not NULL
    if( !is.null( fileColNames ) ) {
      colnames( dataFrame ) <- fileColNames
    }
    
    # add data frame to master list
    dataFrames[[ i ]] <- dataFrame
    
  }
  
  dataFrames
  
}