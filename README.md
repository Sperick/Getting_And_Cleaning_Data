# Getting_And_Cleaning_Data

The "run_analysis.R" file can be run if the working directory is set to the root folder (/"UCI HAR Dataset").

The file itself is well commented with each step explained. In summary though it combines the train and test
data sets which it reads in from the text files. DescriptiveVariable names are read in and used to name the columns.
It then filters out all of the columns that aren't related to means or standard deviations. 
The Activity type for each trial is added as a column to the beginning of the data and this is converted to a label.
Another column is then added which details the subject who was involved in each trial.
Finally, the data is summarized so that we are left with a data table that has the mean for each variable for a given
subject for a given activity. This data is then outputted to a .txt file.


"final.data.txt" contains the final tidy data.

"CodeBook.pdf" contains an explanation of the variables in the tidy data. "features_info.txt" is also included as it is
referenced in the CodeBook.pdf file