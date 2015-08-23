# Getting_and_Cleaning_Data
Course work for John's Hopkins Coursera course of the same name.

## Files
There are five files in this respository:

### README.md

This file.

### run_analysis.R

Takes the raw input data, tidies it up, saves the tidy data, does the analysis, and outputs the analysis as tidy data to disk and screen. This is run with source('run_analysis.R').
                    
### data_dictonary.md

Describes the variables in both the tidy data resulting from the first part of the perform analysis script and the analysis results from the second part.
  
### raw_data_README.txt

The README file included with the raw data.  The data_dictionary references it.  It also provides additional details about the gathering of the data.

### raw_data_features_info.txt

The description of the variables included with the raw data.  The data_dictionary references it.  It provides additional details on variable naming, measurement processing, and variables not selected for inclusion in the tidy data set and later analysis.

## Outline of tidying process

  1. Disabled in the current code but recommended: download the raw data from the source.  It is disabled as the assignment specifically requires
     the program work as long as the data is in the working directory.
  2. Load the features table describing the variables in the data and subset to only get means and standard deviations.
  3. Creates the empty data frame.
  4. Get the activity labels so the tidy data has descriptive instead of numeric values for activity.
  5. For the train and test data sets provided by Samsung do the following to unify them in one data frame.
    a. Load subject, activity, and observation files.
    b. Verify the files all have the same length in rows, otherwise skip this step and provide a warning.
    c. Merge subject, activity as a string, and the desired features into a row in the data frame.
  6. Rename the observation columns to match the factor names provided by Samsung.
  
## Outline of analysis

  Data is grouped by activity and subject then means for each observed variable in each group is computed.

