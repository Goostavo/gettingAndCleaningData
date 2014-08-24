## Gustavo Garcia
## 24 august 2014
## Coursera's Getting and Cleaning data
## Programming Project

#############################################
##Description
# You should create one R script called run_analysis.R that does the following. 

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#############################################
# Clean the environment before starting the work
# WARNING: It will clean all variables
remove(list = ls())

#############################################
#############################################
## Preparing the data set for the analysis
## All the data will be concatenated into a single named data.frame
#############################################
# Loading the dataset from files
print("Loading dataset")
# Loading the sets into variables
subject_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
Y_test <- read.table("test/y_test.txt")

subject_train <- read.table("train/subject_train.txt")
X_train <- read.table("train//X_train.txt")
Y_train <- read.table("train//y_train.txt")

featuresNamesVector <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt")

#############################################
# Merging the training and test sets into a single set
print("Merging training and test sets")

subject_set <- rbind(subject_test, subject_train)
X_set <- rbind(X_test, X_train)
Y_set <- rbind(Y_test, Y_train)

# Cleaning useless variables to free memory
remove(X_test, X_train, subject_test, subject_train, Y_test, Y_train)

#############################################
# Naming the X_set using the features name
print("Naming and isolating mean and std features")

names(X_set) <- featuresNamesVector[,2]

# Isolating the mean and std variables
X_set <- X_set[,(grepl(x = featuresNamesVector[,2], pattern = "mean") | 
                     grepl(x = featuresNamesVector[,2], pattern = "std"))]

# Naming the activity using factor
activity <- as.factor(Y_set$V1)
levels(activity) <- activityLabels[,2]

# Naming the subject number
names(subject_set) <- "SubjectID"

#############################################
# Binding all the data into a single data set
print("Binding all the data into a single dataSet")
tidyDataSet <- cbind(subject_set, activity, X_set)

#Cleaning non necessary variables
remove(X_set, Y_set, activityLabels, featuresNamesVector, subject_set)

#############################################
#############################################
## Creating  a second, independent tidy data set with the average of each variable 
## for each activity and each subject. 
#############################################
print ("Analysing data: Getting average features classified by subject and activity")
# Spliting the data by subjectID

analysisSet <- split(tidyDataSet, list(tidyDataSet$SubjectID, tidyDataSet$activity))

# Using lapply to get the average by column
analysisSet <- lapply(analysisSet, function(x) colMeans(x[,3:81]))

# Regrouping data (NOTE: The subjectID and activity turned into rowNames)
analysisSet <- do.call("rbind",analysisSet)

# Get subjectID and activity back into columns
subjectActivity <- do.call("rbind", strsplit(rownames(analysisSet),'\\.'))
analysisSet <- cbind(subjectActivity,analysisSet)
colnames(analysisSet)[1] <- "subjectID"
colnames(analysisSet)[2] <- "activity"

# Printing data into file
write.table(analysisSet, row.names = FALSE, file = "output.txt")