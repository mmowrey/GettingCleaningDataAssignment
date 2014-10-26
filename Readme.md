<b>The run_analysis.R file:</b>
 * Imports the required data files into R
 * Merges data together to create one data set
 * Extracts desired measurements for mean and standard deviation of each reading
 * Replaces activity IDs with descriptive activity names 
 * Applies more descriptive names to the dataset variables (columns)
 * Creates a tidy data set of the average for each remaining variable for each activity and subject
 * Writes the tidy data set to a SummaryByActivity_Subject.txt file in the working directory


<b>Expected source directory of input files:</b>

(working directory)/data/project/UCI HAR Dataset/


<b>Input files: </b>

test/X_test.txt

test/y_test.txt

test/subject_test.txt

train/X_train.txt

train/y_train.txt

train/subject_train.txt

features.txt


<b>Output files:</b>

SummaryByActivity_Subject.txt 


<b><u>Instructions:</u></b>

1. Open run_analysis.R in R Studio

2. Ensure the input files are unzipped and placed in the appropriate directory as indicated above

3. Execute the run_analysis.R script 

4. Locate the SummaryByActivity_Subject.txt file in the working directory when script execution is complete
