library(dplyr)
# Parts 1-2: Subsetting and Merging Test and Train data
feat <- read.table("UCI HAR Dataset/features.txt")
subfeat <- subset(feat, (grepl("-mean\\(\\)",feat[,2]) | grepl("-std\\(\\)",feat[,2]))) #Select only the -mean() and -std() variables
testx <- read.table("UCI HAR Dataset/test/X_test.txt") #Read test measurement variables
testx <- select(testx,subfeat[,1]) #Subset to -mean() and -std() variables only
testy <- read.table("UCI HAR Dataset/test/y_test.txt") #Read test activity data
testsubj <- read.table("UCI HAR Dataset/test/subject_test.txt") #Read test subject data
testmerge <- cbind(testsubj,testx,testy) #Merge all test data in following order: Subject, Measurements, Activity
trainx <- read.table("UCI HAR Dataset/train/X_train.txt") #Read train measurement variables
trainx <- select(trainx,subfeat[,1]) #Subset to -mean() and -std() variables only
trainy <- read.table("UCI HAR Dataset/train/y_train.txt") #Read train activity data
trainsubj <- read.table("UCI HAR Dataset/train/subject_train.txt") #Read tran subject data
trainmerge <- cbind(trainsubj,trainx,trainy) #Merge all train data in following order: Subject, Measurements, Activity
alldata <- rbind(testmerge,trainmerge) #Merge test and train data (vertically)
alldata[,1] <- factor(alldata[,1]) #Convert subject variables to factors
rm(feat, testx, testy, testsubj, testmerge, trainx, trainy, trainsubj, trainmerge) #Delete original data files
# Part 3: Descriptive Activity Names
activities <- read.table("UCI HAR Dataset/activity_labels.txt") #Read activity data file
activities[,2] <- sub("_"," ", activities[,2]) #Remove underscore characters
activities[,2] <- tolower(activities[,2]) #Lowercase all
for (i in activities[,1]) {
     alldata[,68] <- sub(i,activities[i,2], alldata[,68]) #Change activity variables from numbers by activity description
}
alldata[,68] <- factor(alldata[,68])
# Part 4: Descriptive Variable Names 
names(alldata) <- c("Subject",as.character(subfeat[,2]),"Activity") #Name Columns using original data measurement variable names
for (i in 2:67) {   #Make mesasurement variable names more readable
     names(alldata)[i] <- gsub("^t","Time",names(alldata)[i])
     names(alldata)[i] <- gsub("^f","Freq",names(alldata)[i])
     names(alldata)[i] <- gsub("-mean\\(\\)-","Mean",names(alldata)[i])
     names(alldata)[i] <- gsub("-std\\(\\)-","Std",names(alldata)[i])
     names(alldata)[i] <- gsub("-mean\\(\\)","Mean",names(alldata)[i])
     names(alldata)[i] <- gsub("-std\\(\\)","Std",names(alldata)[i])
}
# Part 5: Create tidy data set with average of each variable for each activity and each subject
library(reshape2)
datamelt <- melt(alldata,id=c(names(alldata)[1],names(alldata)[68]),measure.vars=names(alldata)[2:67]) #Create melted data set with Subject and Activity as IDs for later averaging
tidysubj <- dcast(datamelt, Subject ~ variable, mean) #Create data set with averages by subject
names(tidysubj)[1] <- "AveragedBy" 
tidyactivity <- dcast(datamelt, Activity ~ variable, mean) #Create data set with averages by Activity
names(tidyactivity)[1] <- "AveragedBy"
tidy <- rbind(tidysubj,tidyactivity) #Merge data with averages by subject and averages by activity
tidy[,1] <- as.character(tidy[,1]) #Change subject numer variables from factor to character
for (i in 1:30) {
     tidy[i,1] <- paste("subject",tidy[i,1]) #Make subject variables more readable by adding "subject" at the beginning (e.g. "subject 12" instead of "12")
}
tidy[,1] <- as.factor(tidy[,1]) #Make averaged by variables (subject number and activity) factors
rm(activities,alldata,datamelt,subfeat,tidyactivity,tidysubj) #Delete all non-tidy data
# Create txt file with tidy data set
write.table(tidy,file="tidy.txt",row.name=FALSE)