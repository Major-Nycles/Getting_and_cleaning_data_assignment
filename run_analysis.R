## This script loads and combines two sets of data pertaining to accelerometer and gryoscope reading obtained 
## from a HAR (Human Activity Recognition) device on a smartphone. The data is loaded, tidies and mean and 
## standard deviations of it's relevant features are produced according to the relevant user and one of six
## activities being under-taken.

## The data is first downloaded and stored in an appropriate location.

if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/HAR_dataset.zip", method = "curl")
date.downloaded <- date()
install.packages("zip")
library(zip)
unzip("./data/HAR_dataset.zip", exdir = "./data")


## Load test data
test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
test_activities <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
test_subjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")


## Load training data
train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
train_activities <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
train_subjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

## Load and attach variable labels

features <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE)
features <- features[,2]
test_data <- `colnames<-`(test_data, features)
train_data <- `colnames<-`(train_data, features)
test_activities <- `colnames<-`(test_activities, "Activity")
test_subjects <- `colnames<-`(test_subjects, "Subject")
train_activities <- `colnames<-`(train_activities, "Activity")
train_subjects <- `colnames<-`(train_subjects, "Subject")

## Add subjects and activities to test data
test_data_collated <- cbind(test_subjects,test_activities,test_data)

## Add subjects and activities to train data
train_data_collated <- cbind(train_subjects,train_activities,train_data)

## Row bind the two data sets & add appropriate variable (column) names

combined_data <- rbind(test_data_collated,train_data_collated)

## Only select columns mentioning mean and standard deviation

selected_columns <- grep("[Mm]ean|[Ss]td|Activity|Subject",colnames(combined_data))
selected_data <- combined_data[,selected_columns]

## Tidy up the variable descriptions
colnames(selected_data) <- gsub("^t","Time",colnames(selected_data))
colnames(selected_data) <- gsub("Acc","Accelerometer",colnames(selected_data))
colnames(selected_data) <- gsub("-mean()","Mean",colnames(selected_data))
colnames(selected_data) <- gsub("-std","Std",colnames(selected_data))
colnames(selected_data) <- gsub("Gyro","Gyroscope",colnames(selected_data))
colnames(selected_data) <- gsub("Mag","Magnitude",colnames(selected_data))
colnames(selected_data) <- gsub("^f","Frequency",colnames(selected_data))
colnames(selected_data) <- gsub("BodyBody","Body",colnames(selected_data))
colnames(selected_data) <- gsub("gravity","Gravity",colnames(selected_data))
colnames(selected_data) <- gsub("angle","Angle",colnames(selected_data))
colnames(selected_data) <- gsub("[()]","",colnames(selected_data))
colnames(selected_data) <- gsub("-","_",colnames(selected_data))

## Replace activity numbers with descriptions

activity <- function(x) {
  if(x == 1) {x <- "Walking"}
  else if(x == 2) {x <- "Walking Upstairs"}
  else if(x == 3) {x <- "Walking Downstairs"}
  else if(x == 4) {x <- "Sitting"}
  else if(x == 5) {x <- "Standing"}
  else if(x == 6) {x <- "Laying"}
  else {break}
}

selected_data[,2] = sapply(selected_data[,2], activity)

## Group by Subject and Activity, then take the mean for each variable
library(dplyr)
FinalData <- arrange(selected_data, Subject, Activity)
FinalData <- group_by(FinalData, Subject, Activity)
columnsToAverage <- colnames(FinalData)
FinalTable <- summarise(FinalData, (across(columnsToAverage[3:88], mean)))

## Writes the final output table

write.table(FinalTable, file = "./FinalTable.txt", row.names = FALSE)
