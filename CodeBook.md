# Getting and Cleaning Data Assignemnt Codebook

The data pertaining to this study has been obtained from a Human Activity Recognition System (HAR) obtained from the following repository:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The initial data can be obtained by using the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Initial Data Configuration

The initial data is is structured in the following way:

**activity_labels.txt** - Contains the six integers (1 to 6) that describe each activity measured using the device.

**features_info.txt** - contains descriptions of the feature variables measured by the device.

**features.txt** - contains an indexed list of all 561 feature variables measured by the device. 

**README.txt** - Contains a more detailed description of the original experiment and the reasoning behind its initiation.

The data is comprised of two individual sets; test and train. The sets contain copies of the following files:

**subject_test.txt** - (2947 x 1) a list of subjects (30 individuals) from the test category, whereby each entry corresponds that individual (1-30), with the appropriate activity.

**X_test.txt** - (2947 x 561) the test data for the 561 variables listed in the **features.txt** file.

**y_test.txt.txt** - (2947 x 1) a list of integers (1-6) for the test data wherby each integer corresponds to the activity described in **activity_labels.txt**.

**subject_train.txt** - (7352 x 1) a list of subjects (30 individuals) from the train category, whereby each entry corresponds that individual (1-30), with the appropriate activity.

**X_test.txt** - (7352 x 561) the train data for the 561 variables listed in the **features.txt** file.

**y_test.txt.txt** - (7352 x 1) a list of integers (1-6) for the train data whereby each integer corresponds to the activity described in **activity_labels.txt**.

## Data Collation

The R script within this repository labeled as **run_analysis** collates the three files listed above for the test and train category and combines them into:

**test_data_collated**

**train_data_collated**

These data frames are then combined into one holistic data frame that does not retain the origin of the data (test or train):

**combined_data**

## Feature Selection

The features considered are then condensed by selecting only those than mention Mean, Standard Deviations, Activity and Subject. The descriptions themselves are then tidied to replace abrreviated words, un-capitalised words and undesirable characters. The transformation of these variables can be seen in the **FinalVariables.txt** files contained in this repository.

The number of features has been condensed from 561 to 86.

## Data Summary

The data is then grouped and condensed by obtain the mean value for every feature per Activity and Subject. This data is contained within the **FinalTable.txt** file and contains the data for all 30 subjects and 6 activities each, giving final dimensions of 180 x 88.




