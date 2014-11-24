Code Book
===========
The data contained in tidy.txt corresponds to the averages of the mean and standard
deviation for the data contained in the raw data set. The averages where done by activity
and by subject (participant).

List of Variables in tidy.txt data set:
* AveragedBy: Subject (1-30) or activity (laying, sitting, standing, walking, walking
downstairs and walking upstairs) that was used to obtain the average from the raw data set
* TimeBodyAccMean(X,Y,Z): Time domain signal average for body acceleration (from 
accelerometer) in all 3 axes.
* TimeBodyAccStd(X,Y,Z): Time domain signal standard deviation for body acceleration (from 
accelerometer) in all 3 axes.
* TimeGravityAccMean(X,Y,Z): Time domain signal average for gravity acceleration (from 
accelerometer) in all 3 axes.
* TimeGravityAccStd(X,Y,Z): Time domain signal standard deviation for gravity acceleration 
(from accelerometer) in all 3 axes.
* TimeBodyAccJerkMean(X,Y,Z): Time domain signal average for body jerk (from 
accelerometer) in all 3 axes. [Jerk = Time derivative of acceleration]
* TimeBodyAccJerkStd(X,Y,Z): Time domain signal standard deviation for body jerk (from 
accelerometer) in all 3 axes. [Jerk = Time derivative of acceleration]
* TimeBodyGyroMean(X,Y,Z): Time domain signal average for body acceleration (from 
gyroscope) in all 3 axes.
* TimeBodyGyroStd(X,Y,Z): Time domain signal standard deviation for body acceleration 
(from gyroscope) in all 3 axes.
* TimeBodyGyroJerkMean(X,Y,Z): Time domain signal average for body jerk (from 
gyroscope) in all 3 axes.
* TimeBodyGyroJerkStd(X,Y,Z): Time domain signal standard deviation for body jerk 
(from gyroscope) in all 3 axes.
* TimeBodyAccMagMean: Time domain signal average for body acceleration magnitude (from
accelerometer)
* TimeBodyAccMagStd: Time domain signal standard deviaton for body acceleration magnitude
(from accelerometer)
*