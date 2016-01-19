## Variables
## There are 2 Factor variables and 48 numerical variables in this data.


### activity
	* Factor variable with 3 classes.
	** WALKING
	** WALKING_UPSTAIRS
	** WALKING_DOWNSTAIRS

	** SITTING
	** STANDING

	** LAYING


### subjectID
	* Factor variable which identifies the subject who performed the activity for each sample. Its range is from 1 to 30 corresponding to 30 different individual participated in this study.

### Varibles 3 - 50
	* Mean and standard deviation values for each combination of activity and subject
	* Each variable name has 6 components AAABBBCCCDDDEEEFFF
	** AAA: 'Time' or 'Frequency', depending on how the data was collected/computed
	** BBB: 'Body' or 'Gravity', represent body or gravitation component from sensor acceleration signal
	** CCC: 'Acc' or 'Gyro'
		*** Acc: Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
		*** Gyro: Triaxial Angular velocity from the gyroscope.
	** DDD: 'Jerk' or none: Jerk is obtained by the body linear acceleration and angular velocity
	** EEE: 'Mean': mean value or 'Std': standard deviation
	** FFF: 'X', 'Y' or 'Z' represention the three dimesions

## Data source
###==================================================================
###Human Activity Recognition Using Smartphones Dataset
###Version 1.0
###==================================================================
###Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
###Smartlab - Non Linear Complex Systems Laboratory
###DITEN - Universit?degli Studi di Genova.
###Via Opera Pia 11A, I-16145, Genoa, Italy.
###activityrecognition@smartlab.ws
###www.smartlab.ws
==================================================================

###The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

###The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Data Transformations

1. The test and trainig data set are first merged into one
2. The mean and standard deviation data for the following data are extracted
	*tBodyAcc-XYZ
	*tGravityAcc-XYZ
	*tBodyAccJerk-XYZ
	*tBodyGyro-XYZ
	*tBodyGyroJerk-XYZ
	*fBodyAcc-XYZ
	*fBodyAccJerk-XYZ
	*fBodyGyro-XYZ
3. ActivityIDs are mapped to factor variables containing six lables
	** WALKING
	** WALKING_UPSTAIRS
	** WALKING_DOWNSTAIRS

	** SITTING
	** STANDING

	** LAYING

4. Subject variable are converted to factor
5. Variable names are altered
	** t --> Time
	** f --> Frequency
	** mean --> Mean
	** std --> Std
	** () and - removed
6. The data are split and grouped according to the subject and activity. Average of 'Mean' and 'Std' of each measurement variable are computed in each group. The resulting data is then recasted. The process uses 'reshape2' package's melt and dcast functions



