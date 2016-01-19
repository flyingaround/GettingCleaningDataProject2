#This script is the answer to Project 2 or Getting and Cleaning Data course
#Pupuroses:
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each 
#   measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
#Data downloaded from 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# removed variables from workspace
rm(list = ls())


filename <- "UCIHAR.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
    URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(URL, filename, mode = 'wb')
}  
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

# read activity labels and features from root directory
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

# Assign appropritate col names to activity and features
colnames(activity) <- c("activityID", "activity")
colnames(features) <- c("featureID", "feature")

# 1. read and combine training and test set data
#read training set data and assign appropriate data label
train_data_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
colnames(train_data_y) <- "activityID"
train_data_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
#col names in data set should be the feature names
colnames(train_data_x) <- features$feature
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(train_subject) <- "subjectID"

#combine training data through cbind
train_combine <- cbind(train_data_x, train_subject, train_data_y)

#read test set data and assign appropriate data label
test_data_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
colnames(test_data_y) <- "activityID"
test_data_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
#col names in data set should be the feature names
colnames(test_data_x) <- features$feature
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(test_subject) <- "subjectID"

#combine test data through cbind
test_combine <- cbind(test_data_x, test_subject, test_data_y)

#combine training and test data through rbind
data_combine <- rbind(train_combine, test_combine)

#2. Extracts only the measurements on the mean and standard deviation for each 
#   measurement.
colnam <- names(data_combine)
#find col index of mean and standard deviation measurement
ind <- grep("-mean\\()-|-std\\()-|activityID|subjectID", colnam)
#extract only mean and standard deviation and combine with subjectID and activity ID
data_mean_stdev <- cbind(data_combine[ , ind])

#3. Uses descriptive activity names to name the activities in the data set
data_mean_stdev$activityID <- factor(data_mean_stdev$activityID,
                                     levels = activity$activityID,
                                     labels = activity$activity)
# Also make subject ID a factor
data_mean_stdev$subjectID <- as.factor(data_mean_stdev$subjectID)

# 4. Appropriately labels the data set with descriptive variable names.
# substitube t with 'time'
colnam <- names(data_mean_stdev)
#remove '()'
colnam <- gsub("\\()", "", colnam)
#replace '^t' by 'time'
colnam <- gsub("^(t)", "Time", colnam)
#replace("^f) by 'frequency'
colnam <- gsub("^(f)", "Frequency", colnam)
#remove remaining '-'
colnam <- gsub("-", "", colnam)
colnam <- gsub("mean", 'Mean', colnam)
colnam <- gsub("std", 'Std', colnam)
colnam <- gsub("activityID", "activity", colnam)
#to reduce the difficulty of reading, capitals letters of 'Time', 'Body' and etc
# are retained in the variable names.

#update col names
colnames(data_mean_stdev) <- colnam

#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject

#load reshape2 library
library(reshape2)

allData_melted <- melt(data_mean_stdev, id = c("subjectID", "activity"))
allData_mean <- dcast(allData_melted, subjectID + activity ~ variable, mean)

write.table(allData_mean, "tidydata.txt", row.names = FALSE, quote = FALSE)

