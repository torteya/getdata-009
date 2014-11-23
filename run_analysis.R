library(dplyr)
# Parts 1-2: Subsetting and Merging Test and Train data
feat <- read.table("UCI HAR Dataset/features.txt")
subfeat <- subset(feat, (grepl("-mean\\(\\)",feat[,2]) | grepl("-std\\(\\)",feat[,2])))
testx <- read.table("UCI HAR Dataset/test/X_test.txt")
testx <- select(testx,subfeat[,1])
testy <- read.table("UCI HAR Dataset/test/y_test.txt")
testsubj <- read.table("UCI HAR Dataset/test/subject_test.txt")
testmerge <- cbind(testsubj,testx,testy)
trainx <- read.table("UCI HAR Dataset/train/X_train.txt")
trainx <- select(trainx,subfeat[,1])
trainy <- read.table("UCI HAR Dataset/train/y_train.txt")
trainsubj <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainmerge <- cbind(trainsubj,trainx,trainy)
alldata <- rbind(testmerge,trainmerge)
alldata[,1] <- factor(alldata[,1])
rm(feat, testx, testy, testsubj, testmerge, trainx, trainy, trainsubj, trainmerge)
# Part 3: Descriptive Activity Names
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[,2] <- sub("_"," ", activities[,2])
activities[,2] <- tolower(activities[,2])
for (i in activities[,1]) {
     alldata[,68] <- sub(i,activities[i,2], alldata[,68])
}
alldata[,68] <- factor(alldata[,68])
# Part 4: Descriptive Variable Names 
names(alldata) <- c("Subject",as.character(subfeat[,2]),"Activity")
for (i in 2:67) {
     names(alldata)[i] <- gsub("^t","Time",names(alldata)[i])
     names(alldata)[i] <- gsub("^f","Freq",names(alldata)[i])
     names(alldata)[i] <- gsub("-mean\\(\\)-","Mean",names(alldata)[i])
     names(alldata)[i] <- gsub("-std\\(\\)-","Std",names(alldata)[i])
     names(alldata)[i] <- gsub("-mean\\(\\)","Mean",names(alldata)[i])
     names(alldata)[i] <- gsub("-std\\(\\)","Std",names(alldata)[i])
}
# Part 5: Create tidy data set with average of each variable for each activity and each subject
library(reshape2)
datamelt <- melt(alldata,id=c(names(alldata)[1],names(alldata)[68]),measure.vars=names(alldata)[2:67])
tidysubj <- dcast(datamelt, Subject ~ variable, mean)
names(tidysubj)[1] <- "AveragedBy"
tidyactivity <- dcast(datamelt, Activity ~ variable, mean)
names(tidyactivity)[1] <- "AveragedBy"
tidy <- rbind(tidysubj,tidyactivity)
tidy[,1] <- as.character(tidy[,1])
for (i in 1:30) {
     tidy[i,1] <- paste("subject",tidy[i,1])
}
tidy[,1] <- as.factor(tidy[,1])
rm(activities,alldata,datamelt,subfeat,tidyactivity,tidysubj)
# Create txt file with tidy data set
write.table(tidy,file="tidy.txt",row.name=FALSE)