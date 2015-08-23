# Getting_and_Cleaning_Data
Course work for John's Hopkins Coursera course of the same name.

There are two files in this respository:

perform_analysis.R: Takes the raw input data, tidies it up, saves the tidy data, 
                    does the analysis, and outputs the analysis as tidy data to disk and screen.
                    This is run with source('perform_analysis.R').
data_dictonary.txt: Describes the variables in both data sets.

Outline of tidying process:
  1. Disabled but recommended: download the raw data from the source.  It is disabled as the assignment specifically requires
     the program work as long as the data is in the working directory.
  2. Load the features table describing the variables in the data and subset to only get means and standard deviations.
  3. Creates the empty data frame.
  4. Get the activity labels so the tidy data has descriptive instead of numeric values for activity.
  5. For the train and test data sets provided by Samsung do the following to unify them in one data frame.
    a. Load subject, activity, and observation files.
    b. Verify the files all have the same length in rows, otherwise skip this step and provide a warning.
    c. Merge subject, activity as a string, and the desired features into a row in the data frame.
  6. Rename the observation columns to match the factor names provided by Samsung.
  
Outline of analysis: Data is grouped by activity and subject then means for each observed variable in each group is computed.

