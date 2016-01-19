#This is the README file for the script run_analysis.R, submitted for Project 2 of the Coursera course Getting and Cleaning Data.

#The script has 5 sections

1. Merges the training and the test sets to create one data set.

	* The data is first downloaded into the work directory
	* activity and feature labels are first read into R worspace, with the column names set to "ID" and "Name", repectively
	* Training and test data (y, x and subject) are read into R workspace. The colmn names are mapped to respective activity names and feature names, using the activity and feature variable obtained from previous steps
	* Y, X and subject variables are first merged within test and training data using cbind
	* test and training data are merged with rbind

2.  Extracts only the measurements on the mean and standard deviation for each measurement.
	* From the column names, we search and extract the indices of col names containing "-mean()-", "-std()-" and activity/subject IDs
	* note that meanfreq is not selected as these cols are not raw data
	* we then subset those required columns

3. Uses descriptive activity names to name the activities in the data set
	* we set the activity names descriptively by factoring the activity column with levels mapped to activity$activityID and labels mapped to activity$activity
	* Set column name to activity
	* subjectID is also converted to factor variable for later use, when we melt and cast the final data

4. Appropriately labels the data set with descriptive variable names
	*'Appropriate' is subjective here.
	*Removed () in variable names
	*replaced t by 'Time', f by 'Frequency', mean by 'Mean', std by 'Std
	*removed extra hyphens ('-')
	*some capital letters are retained to aid reading

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
	*used reshape2 library for this purpose
	*first melt the data with id set to subjectID and activityID
	*cast the data with mean function argument
	*write the datato "tidydata.txt"
