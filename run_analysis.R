library(plyr)
library(reshape2)

#read the names of the activities and features
mainpath <- "UCI HAR Dataset/"

filename <- paste(mainpath, "activity_labels.txt", sep="")
cl <- c("numeric","character")
names <- c("id", "name")
activities <- read.table(filename, colClasses = cl, col.names = names )

filename <- paste(mainpath, "features.txt", sep="")
cl <- c("numeric","character")
names <- c("id", "name")
allfeatures <- read.table(filename, colClasses = cl, col.names = names )


#read the data from both the test folder and train folder
groups <- c("test", "train")

filename <- paste(mainpath, "/", groups[1], "/X_", groups[1],".txt", sep="")
data1 <- read.table(filename)

filename <- paste(mainpath, "/", groups[1], "/y_", groups[1],".txt", sep="")
act1 <- read.table(filename)
data1$Activity <- as.numeric(act1[, 1])

filename <- paste(mainpath, "/", groups[1], "/subject_", groups[1],".txt", sep="")
sub1 <- read.table(filename)
data1$Subject <- as.numeric(sub1[, 1])


filename <- paste(mainpath, "/", groups[2], "/X_", groups[2],".txt", sep="")
data2 <- read.table(filename)

filename <- paste(mainpath, "/", groups[2], "/y_", groups[2],".txt", sep="")
act2 <- read.table(filename)
data2$Activity <- as.numeric(act2[, 1])

filename <- paste(mainpath, "/", groups[2], "/subject_", groups[2],".txt", sep="")
sub2 <- read.table(filename)
data2$Subject <- as.numeric(sub2[, 1])

# combine the data
alldata <- rbind(data1, data2)

# select the columns with the mean and standard deviation
positionsmean <- grep("-mean()", allfeatures[, "name"], fixed=TRUE )
positionsstd <- grep("-std()", allfeatures[, "name"], fixed=TRUE  )

allpositions <- c(positionsmean, positionsstd)
allpositions <- allpositions[sort.list(allpositions)]

# add the subject and activity columns
selecnames <- allfeatures[allpositions, "name"]
selecnames <- c(selecnames, "Subject", "Activity")

extrapositions1 <-which(colnames(data1) %in% c("Subject"))
extrapositions2 <-which(colnames(data1) %in% c("Activity"))
allpositions <- c(allpositions, extrapositions1, extrapositions2)


# create a new data frame with the selected columns
tidy_data <- alldata[, allpositions]

# set activity and subject as factor columns
tidy_data$Activity <- as.factor(tidy_data$Activity)
tidy_data$Subject <- as.factor(tidy_data$Subject)


# rename manually both the activity names and the features measured
tidy_data$Activity <- revalue(tidy_data$Activity, c("1"="Walking", "2" = "Walking Upstars",
     "3" = "Walking Downstairs", "4" = "Sitting", "5" = "Standing", "6" = "Laying"))

newnames <- c("MeanBodyAcc-X", "MeanBodyAcc-Y", "MeanBodyAcc-Z", 
              "StdBodyAcc-X", "StdBodyAcc-Y", "StdBodyAcc-Z",
           "MeanGravityAcc-X",  "MeanGravityAcc-Y",  "MeanGravityAcc-Z",
           "StdGravityAcc-X",   "StdGravityAcc-Y", "StdGravityAcc-Z",
           "MeanBodyAccJerk-X",  "MeanBodyAccJerk-Y",  "MeanBodyAccJerk-Z", 
           "StdBodyAccJerk-X", "StdBodyAccJerk-Y", "StdBodyAccJerk-Z",
           "MeanBodyGyro-X",  "MeanBodyGyro-Y",    "MeanBodyGyro-Z", 
           "StdBodyGyro-X","StdBodyGyro-Y", "StdBodyGyro-Z",
           "MeanBodyGyroJerk-X",  "MeanBodyGyroJerk-Y",    "MeanBodyGyroJerk-Z", 
           "StdBodyGyroJerk-X","StdBodyGyroJerk-Y", "StdBodyGyroJerk-Z",
           "MeanBodyAcc-Mag", "StdBodyAcc-Mag", 
           "MeanGravityAcc-Mag", "StdGravityAcc-Mag",
           "MeanBodyAccJerk-Mag", "StdBodyAccJerk-Mag",
           "MeanBodyGyro-Mag", "StdBodyGyro-Mag",
           "MeanBodyGyroJerk-Mag", "StdBodyGyroJerk-Mag",
           "MeanBodyAcc-X-FFT", "MeanBodyAcc-Y-FFT", "MeanBodyAcc-Z-FFT", 
           "StdBodyAcc-X-FFT", "StdBodyAcc-Y-FFT", "StdBodyAcc-Z-FFT",
           "MeanBodyAccJerk-X-FFT", "MeanBodyAccJerk-Y-FFT", "MeanBodyAccJerk-Z-FFT", 
           "StdBodyAccJerk-X-FFT", "StdBodyAccJerk-Y-FFT", "StdBodyAccJerk-Z-FFT",
           "MeanBodyGyro-X-FFT", "MeanBodyGyro-Y-FFT", "MeanBodyGyro-Z-FFT", 
           "StdBodyGyro-X-FFT", "StdBodyGyro-Y-FFT", "StdBodyGyro-Z-FFT",   
           "MeanBodyAcc-Mag-FFT", "StdBodyAcc-Mag-FFT", 
           "MeanBodyAccJerk-Mag-FFT", "StdBodyAccJerk-Mag-FFT",
           "MeanBodyGyro-Mag-FFT", "StdBodyGyro-Mag-FFT",
           "MeanBodyGyroJerk-Mag-FFT", "StdBodyGyroJerk-Mag-FFT",
           "Subject", "Activity"
           )

colnames(tidy_data) <- newnames

#generate a wide data frame that obtains the means of the columns according to their
#activity and subject level
aggdata <- aggregate(tidy_data[-c(67, 68)],
                     by=list(tidy_data$Activity, tidy_data$Subject), FUN=mean)

#transform the wide data into long data
finaldata <- melt(aggdata, id.vars=c("Group.1", "Group.2"))

#rename the columns again
colnames(finaldata) <- c("Activity", "Subject", "Feature", "Mean")

#write the tidy data into the file "featuremeans.txt"
write.table(finaldata, file="featuremeans.txt", row.name=FALSE )
