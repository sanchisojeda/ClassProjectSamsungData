# Code Book describing the data set "featuresmean.txt"

This dataset is a summarized version of the dataset that can be found in 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script "run_analysis.R" takes that dataset as an input, reading all the different measured variables in both the test and train folders, combining them into a complete data set, to then average all the observations taken for the same subject doing the same activity. 

The dataset produced by the "run_analysis.R" contains 4 different variables measured and a total of 11880 independent measurements. The 4 different variables are:

1. Activity (factor with 6 different levels): The different measurements of the features were realized during six different common activities, as defined in the "activity_labels.txt" file on the original dataset. These activities are described as "Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing" and "Laying".

2. Subject (factor with 30 different levels): A total of 30 people participated in the experiment, and they were label with a number ranging from 1 to 30.

3. Feature (factor with 66 different levels): The original experiment described all the different features measured in the "features_info.txt" file. In summary the body and gravity acceleration were measured in the three dimensions XYZ, and the angular velocity in three dimensions was derived from these (Gyro). From these, the Jerk signals (body and gyro) were obtained in three dimensions, and the euclidean norm was used to obtain the magnitude of these five features. A selected group of these features was transformed from the time domain to the frequency domain using the Fast Fourier Transform (FFT). The names of the different levels of this factor are constructed as "MeasureName-Dimension(-FFT)" where the different parts are:
  1. Measure: Describes whether the mean (=Mean) or standard deviation (=Std)  of the given feature was obtained.
  2. Name: The name follows the convention of the initial dataset, with words like BodyAcc or GravityAcc to describe the feature. The Jerk word is added if we are describing a Jerk variable.
  3. Dimension: This is equal to X, Y, or Z to describe which of the three dimensions was measured, or equal to Mag if the euclidean norm was used.
  4. FFT: This suffix is only added if we are talking about the FFT version of a varible.

4. Mean (numeric column): Is the mean value for all the orignal observations for the given feature, in a given activity and for the given subject. 

The data has not been treated further than obtaining the mean for the column 4 variable. No NA values have been removed nor has it been renormalized. Since all the original features were normalized, the means do not have any unit. The only major change is on the feature names, which have been rewritten by hand to avoid mistakes or typos on the names used on the original dataset. 
