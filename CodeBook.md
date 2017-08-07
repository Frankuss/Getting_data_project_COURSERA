This file describes the output of the R script "run_analysis.R", that is the data set which contains the average of each variable for each activity and subject (file "Output_dataset.txt", R object "output_dataset").

----------------------------------------------------------------------------------------------------------------------------

1. DESCRIBING THE INITIAL DATA
The files used for building the "output_dataset" are:
- "X_test.txt": after tidying consists of 2947 obs. (measurements) of 561 variables (features)
- "X_train.txt": after tidying consists of 7352 obs. (measurements) of 561 variables (features)
- "subject_test.txt": consists of 2947 elements containing the information "subject" for each measurement of the set "X_test.txt"
- "subject_train.txt": consists of 7352 elements containing the information "subject" for each measurement of the set "X_train.txt"
- "y_test.txt": consists of 2947 elements containing the information "activity" for each measurement of the set "X_test.txt"
- "y_train.txt": consists of 7352 elements containing the information "activity" for each measurement of the set "X_train.txt"
- "activity_labels.txt": useful in order to convert the "activity" that in the files "y_test.txt" and "y_train.txt" is in a numeric format to the "activity" in a more descriptive format
- "features.txt": consists of 561 obs. containing the information of the correct column names to give to "X_test.txt" and "X_train.txt" sets

----------------------------------------------------------------------------------------------------------------------------

2. BUILDING THE DATA SET "output_dataset"

The complete description of the operations needed in order to build the final data set is included in the comments of the R script "run_analysis.R". Here's a summary of the main operations done by the script.

The script "run_analysis.R":

- Downloads and unzips the zip file ("UCI HAR Dataset.zip") in the default working directory
- Imports in the R global environment all the files needed, starting from the training ("X.train.txt") and test ("X.test.txt") sets, which are cleaned and transformed in data frames

	(the next steps are applied to both the previous sets before the merging operation)

- renames columns using the variable names defined in the file "features.txt"
- adds for each observation the information about the subject (from "subject_train.txt" and "subject_test.txt" files)
- adds for each observation the information about the activity (from "y_train.txt" and "y_test.txt" files)
- substitutes the activity values with descriptive activity names using the conversion file "activity_labels.txt"
- gives as an implicit output the final form of the data train and test sets, saved in the R objects "TRAIN" and "TEST":
	- TRAIN: 7352 obs. of 563 variables
	- TEST: 2947 obs. of 563 variables
563 variables = 561 variables defined in the file "features.txt" + 2 added variables (columns "subject" and "activity")
- merges TRAIN and TEST data sets in a new data set (R object: "Merged_dataset"):
	- Merged_dataset: 10299 obs. of 563 variables

	(the next steps are applied to the merged data set)

- creates a new data set selecting from the merged data set only the columns subject, activity and all that contain in their names the string "mean()" or "std()" (R object: "Subset_Merged_dataset"):
	- Subset_Merged_dataset: 10299 obs. of 68 variables
- creates a new data set with the average of each variable for each activity and subject (contained in the R object "output_dataset", but also in the file "Output_dataset.txt", the final output of the R script):
	- output_dataset: 180 obs. of 68 variables

----------------------------------------------------------------------------------------------------------------------------

3. DIMENSION OF THE DATA SET "output_dataset"
- Number of observations: 180

180 is the result of the 30 subjects participating to the activities multiplied by the number of activities performed by each subjects (6), that is:

1 laying
2 sitting
3 standing
4 walking
5 walking downstairs
6 walking upstairs

- Number of variables: 68

68 is the result of the selection of the columns of the initial TRAIN and TEST data sets. In particular 68 is obtaining choosing the following variables:

1 subject
2 activity
3 all the variables of the initial sets including in their name the string "mean()" or "std()"

----------------------------------------------------------------------------------------------------------------------------

4. UNITS OF THE VARIABLES IN THE DATA SET "output_dataset"
- "subject": Factor, 30 levels (30 subjects)
- "activity": Factor, 6 levels (6 activities, see section 3.)
- Other columns (selected features): numbers; normalized and bounded within [-1:+1]

