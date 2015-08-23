## run_analysis.R: Perform data analysis on the UCI HAR Dataset for
##                 John's Hopkins Getting and Cleaning Data Class
##
## Herbert Nowell
## 2015.08.23
##

## Get the file from the internet, store it locally, and unzip
## This section is not required by the assignment ("The code should have a file
## run_analysis.R in the main directory that can be run as long as the Samsung 
## data is in your working directory" but I believe that a truly reproducable 
## dataset would use it to ensure reproductions used uncorrupted data from the 
## source.
# UNCOMMENT BEFORE PRODUCTION ANALYSIS #raw_data_file_remote <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
# UNCOMMENT BEFORE PRODUCTION ANALYSIS #raw_data_file_local <- "human_activity_recognition_using_smartphones.zip";
# UNCOMMENT BEFORE PRODUCTION ANALYSIS #download.file( raw_data_file_remote, raw_data_file_local, cacheOK=FALSE);
# UNCOMMENT BEFORE PRODUCTION ANALYSIS #unzip( raw_data_file_local, overwrite = TRUE, junkpaths = FALSE );

## Setup some file data 
base_path <- "UCI HAR Dataset";
data_subsets <- c("train", "test");

## Load the features list
## We need this before the dataframe to identify needed rows
features_file <- file.path(base_path, "features.txt", 
                           fsep = .Platform$file.sep);
features_list <- read.table(features_file, stringsAsFactors=FALSE);
features_desired <- subset(features_list, grepl("mean|std", features_list$V2, perl=TRUE));

## Create our final tidy data dataframe
#tidy_data_frame <- data.frame();
tidy_data_frame <- data.frame();

## Load the activity labels 
activity_label_file <- file.path(base_path, "activity_labels.txt", 
                                 fsep = .Platform$file.sep);
activity_labels <- read.table(activity_label_file);

## Load and tidy up the data
data_row_count = 1;
for( subset in data_subsets )
   {
   ## Load data files
   subject_file_name <- paste( "subject_", subset, ".txt", sep = '' );
   subject_file <- file.path( base_path , subset, subject_file_name, 
                              fsep = .Platform$file.sep );
   activity_file_name <- paste( "Y_", subset, ".txt", sep = '' );
   activity_file <- file.path( base_path , subset, activity_file_name, 
                              fsep = .Platform$file.sep );
   observation_file_name <- paste( "X_", subset, ".txt", sep = '' );
   observation_file <- file.path( base_path , subset, observation_file_name, 
                              fsep = .Platform$file.sep );
   subject_table <- read.table(subject_file);
   activity_table <- read.table(activity_file);
   observation_table <- read.table(observation_file);

   ## All three tables should have the same row count
   if (  nrow(subject_table) == nrow(activity_table)
      && nrow(subject_table) == nrow(observation_table) )
      {
      ## for each line
         for( i in 1:nrow(subject_table) )
         {
         ## Read the next subject
         subject <- subject_table[i, 1];
         tidy_data_frame[data_row_count, "subject"] <- subject;
         ## read activity and cross ref with labels, write label to data frame
         activity <- activity_table[i, 1];
         activity_label <- activity_labels[activity_labels[1] == activity][2];
         tidy_data_frame[data_row_count, "activity"] <- activity_label;
         ## For each mean and std dev column copy to data frame
         for( column_number in features_desired$V1 )
            {
            column_label <- paste("V", column_number, sep='');
            observation <- observation_table[i, column_label];
            tidy_data_frame[data_row_count, column_label] <- observation;
            }
         data_row_count <- data_row_count + 1;
         }
      }
   ## If all three files do not have the same row count the data is mismatched and should be skipped.
   ## The error is reported to the user.
   else
      {
      print(past("For subset ", subset, " the files did not all have the same number of rows."));
      print("The data is considered corrupt and will be skipped for this subset.");
      }
   }

## Rename the columns of the dataframe
for( i in 1:nrow(features_desired ))
   {
   column_label <- paste("V", features_desired[i,1], sep='');
   column_name <- features_desired[i,2];
   names(tidy_data_frame)[names(tidy_data_frame) == column_label] <- column_name;
   }

## Save the tidied data prior to analysis
write.table(tidy_data_frame, 'samsung_data_tidy.txt');

## Do required analysis
tidy_analysis <- aggregate(tidy_data_frame[, 3:ncol(tidy_data_frame)], 
                           list(subject = tidy_data_frame$subject, 
                                activity = tidy_data_frame$activity), 
                           mean);

## Update row names in analysis results
target_names <- subset(names(tidy_analysis), ! grepl("subject|activity", names(tidy_analysis), perl=TRUE))
for( name in target_names )
	{
	post_analysis_name <- paste("Mean", "of", name, sep='_');
	names(tidy_analysis)[names(tidy_analysis) == name] <- post_analysis_name;
   }

## Write analysis results to disk and the screen
write.table(tidy_analysis, 'analysis_results_tidy.txt', row.names=FALSE);
print(tidy_analysis);
