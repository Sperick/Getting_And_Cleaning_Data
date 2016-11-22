
        ## Read in Normalised data from both the train and test sets
        x_train <- read.table("train/X_train.txt");
        x_test <- read.table("test/X_test.txt");
        ## Combine both sets 
        x_combined <- rbind(x_train, x_test);
        
        ## Read in the features
        features <- read.table("features.txt");
        
        ## Obtain the features that contain either "mean" or "std and combines
        meanNames <- grep("mean", features$V2);
        stdNames <- grep("std", features$V2);
        colsToKeep <- c(meanNames, stdNames);
        
        ## Use the colsToKeep vector to index to only the columns that we want
        means_and_stds <- x_combined[colsToKeep];
        ## We can do the same with the feature names
        colDescriptiveNames <- features$V2[colsToKeep];
        ## Apply the names to the columns of the dataset
        names(means_and_stds) <- colDescriptiveNames;
        
        ## Read in numerical activity data from both the train and test sets
        y_train <- read.table("train/y_train.txt");
        y_test <- read.table("test/y_test.txt");
        ## Combine both sets 
        y_combined <- rbind(y_train, y_test);
        
        
        ## Add this vector as a column to the begnning of the data set and add a name
        appendedActivities <- cbind(y_combined, means_and_stds);
        names(appendedActivities)[1] = "Activities";
        
        ## Read in the activity labels
        activity_labels <- read.table("activity_labels.txt");
        ## Convert the activity numbers to labels
        appendedActivities$Activities <- activity_labels$V2[appendedActivities$Activities];
        
        
        ## Read in subject information from both the train and test sets
        subject_train <- read.table("train/subject_train.txt");
        subject_test <- read.table("test/subject_test.txt");
        ## Combine both sets 
        subject_combined <- rbind(subject_train, subject_test);
        
        ## Add this vector as a column to the begnning of the data set and add a name
        appendedSubjects <- cbind(subject_combined, appendedActivities);
        names(appendedSubjects)[1] = "Subject";
        
        ## load dplyr package for final stage
        library(dplyr);
        
        ## Group by activity and subject
        grouped_data <- group_by(appendedSubjects, Activities, Subject);

        ## Get the mean value of all of the other columns for each of these groups
        grouped_means <- summarise_each(grouped_data, funs(mean));
        
        ## Finally arrange by Activity and Subject
        final_data <- arrange(grouped_means, Activities, Subject);
        
        ## Output data to .txt fie
        write.table(final_data, "final.data.txt", row.name = FALSE)