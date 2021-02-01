# Getting and Cleaning Data Assignment

This repository contains the deliverables pertaining to Roger D. Peng and Jeff 
Leek's course assignment on Getting and Cleaning Data. Along with this README, the repository contains the following files:

* **run_analysis.R** 
+ Downloads the required data sets and stores them in an appropriate directory.
+ Loads the independent test and training data.
+ Loads and attaches original variable labels.
+ Combines subject ID's and activity labels with test and train data sets.
+ Binds the two independent data sets into one combined set.
+ Selects the variables containing means and standard deviations.
+ Tidies up the variable descriptions.
+ Replaces activity ID with descriptive identifiers.
+ Groups the data by Subject and Activity and obtains a mean for each variable.
+ Creates and outputs the Final Table as a deliverable.
* **CodeBook.md**
* **FinalTable**
+ FinalTable.txt is contains a 180 x 88 data table.
+ Specifies the mean measurements of 30 different subjects performing 6 different activities.
+ 86 different measurements have been averaged
