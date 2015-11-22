library(plyr)
library(dplyr)

#############################################################
#Merges the training and the test sets to create one data set
#############################################################
#read datasets
x_train <- read.table("train/X_train.txt",header = FALSE)
y_train <- read.table("train/y_train.txt",header = FALSE)
sub_train <- read.table("train/subject_train.txt",header = FALSE)

x_test <- read.table("test/X_test.txt",header = FALSE)
y_test <- read.table("test/y_test.txt",header = FALSE)
sub_test <- read.table("test/subject_test.txt",header = FALSE)

#merge datasets
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
sub_data <- rbind(sub_train, sub_test)

#######################################################################################
#Extracts only the measurements on the mean and standard deviation for each measurement
#######################################################################################

#read feature data
f <- read.table("features.txt",header = FALSE)

#filter by mean and standard deviation
f1 <- grep("-(mean|std)\\(\\)", f[, 2])

#extract only the mean and std variables
x_data <- x_data[,f1]

#######################################################################################
#Uses descriptive activity names to name the activities in the data set
#######################################################################################

#load activity data
activities <- read.table("activity_labels.txt",header = FALSE)

#replace IDs in y_data with active labels
y_data[, 1] <- activities[y_data[, 1], 2]


#######################################################################################
#Appropriately labels the data set with descriptive variable names. 
#######################################################################################

#label variable names
names(x_data) <- f[f1, 2]
names(y_data) <- c("activity")
names(sub_data) <- c("subject")

#combine all data
all_data <- cbind(sub_data, y_data, x_data)

#######################################################################################
#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.
#######################################################################################

aggregate_data <- aggregate(. ~subject + activity, all_data, mean)

write.table(aggregate_data, file = "tidydata.txt",row.name=FALSE)



