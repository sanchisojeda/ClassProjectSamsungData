# ClassProjectSamsungData
Final project of the Getting and Cleaning Data course from coursera

This repository contains two files in addition to this README file.

1) File "run_analysis.R" contains a code to read and clean the data on the movement
of several users obtained with the Samsung Galaxy S smartphone. 

2) File CodeBook.md contains a description of the different variables
contained in the tidy dataset produced by the "run_analysis.R" script.


The script "run_analysis.R" requires two R packages to run: plyr and
reshape2. The first two lines of code call both packages, but the user
needs to install these packages before running the script. The script
also assumes that the data found in this link

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

has been unzipped and copied to the working directory, with the name
"UCI HAR Dataset", and that no files have been altered in the process.

The script first reads all the names of the activities and features
from the main data folder, and then it reads all the data collected in
both the test and train datasets. The data is combined using the rbind
function. The columns that contain the mean and standard deviation of
the features are selected using the grep command, and a smaller data
frame is created with only those columns and the columns that contain
the subject and activity levels.

The names of the activity levels and the columns are then set
manually, in an attempt to make them more readable. Finally, the
commans aggregate and melt are used to create a tidy dataset that only
contains the means of each of the properties of each feature for a
given activity and subject. The final dataset can be found
on the working directory with the name "featuremeans.txt".
