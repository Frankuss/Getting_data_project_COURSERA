#DOWNLOADING ALL THE FILES
url_file = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("UCI HAR Dataset.zip")) {
        download.file(url = url_file,
                      destfile = "UCI HAR Dataset.zip",
                      mode="wb")
        unzip(zipfile = "UCI HAR Dataset.zip")
}


#TEST_DATASET---------------------------------------------------------------------------------------------------------

#Saving the starting working directory
start_directory=getwd()

#Creating an output working directory
dir.create(path = paste(start_directory, "/", "UCI HAR Dataset", "/", "Output", sep = ""))

#Importing TEST dataset, formed by 2947 rows
file_position = paste(start_directory, "/", "UCI HAR Dataset", "/", "test", "/", "X_test.txt", sep = "")
TEST=readLines(con = file_position)

#Substituting double spaces with spaces. After that every row of TEST is formed by numbers separated by a single space
TEST=gsub(pattern = "  ", replacement = " ", x = TEST)

#Splitting every row of TEST in 562 single elements (TEST becomes a list)
TEST=strsplit(x = TEST, split = " ")

#Eliminating the first element of each row of the list (an empty element)
Eliminate_first = function (list_element) {
        list_element=list_element[list_element!=""]
}

TEST=lapply(X = TEST, FUN = Eliminate_first)

#Checking that the length of every TEST element is actually 562-1 = 561 
length_vector=sapply(X = TEST, FUN = length)
length_vector[length_vector!=561]

#Changing the class of every atomic element of TEST in numeric
TEST=lapply(X = TEST, FUN = as.numeric)

#Chaging TEST from class list to class data frame
TEST=as.data.frame(TEST)

#TEST is transposed (final result: 2947 obs x 561 variables)
TEST=as.data.frame(t(TEST))

#For every observation there are data of the 561 features (e.g. "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", ...)

#Importing SUBJECT_TEST data set, formed by 2947 obs, and setting it as a data frame
file_position = paste(start_directory, "/", "UCI HAR Dataset", "/", "test", "/", "subject_test.txt", sep = "")
SUBJECT_TEST=as.data.frame(read.table(file = file_position, header = FALSE))

#Importing ACTIVITY_TEST data set, formed by 2947 obs, and setting it as a data frame
file_position = paste(start_directory, "/", "UCI HAR Dataset", "/", "test", "/", "y_test.txt", sep = "")
ACTIVITY_TEST=read.table(file = file_position, header = FALSE)
ACTIVITY_TEST=sapply(X = ACTIVITY_TEST, FUN = as.character)

#Substituting activity number with descriptive activity names
ACTIVITY_TEST=gsub(pattern = "1", replacement = "walking", x = ACTIVITY_TEST)
ACTIVITY_TEST=gsub(pattern = "2", replacement = "walking upstairs", x = ACTIVITY_TEST)
ACTIVITY_TEST=gsub(pattern = "3", replacement = "walking downstairs", x = ACTIVITY_TEST)
ACTIVITY_TEST=gsub(pattern = "4", replacement = "sitting", x = ACTIVITY_TEST)
ACTIVITY_TEST=gsub(pattern = "5", replacement = "standing", x = ACTIVITY_TEST)
ACTIVITY_TEST=gsub(pattern = "6", replacement = "laying", x = ACTIVITY_TEST)

ACTIVITY_TEST=as.data.frame(ACTIVITY_TEST)

#Enriching TEST with the subject and the activity information
TEST=cbind(TEST, SUBJECT_TEST, ACTIVITY_TEST)

#Importing feature names in order to name colums with the names defined in the file features.txt
file_position = paste(start_directory, "/", "UCI HAR Dataset", "/", "features.txt", sep = "")
FEATURES_NAMES=readLines(con = file_position)

#Cleaning feature names from the numbers at the beginning of the name
FEATURES_NAMES=gsub(pattern = "^.+ ", replacement = "", x = FEATURES_NAMES)

#Changing class of FEATURES_NAMES as a vector
FEATURES_NAMES=as.vector(t(FEATURES_NAMES))

#Creating test column names merging FEATURES_NAMES, "subject" and "activity" (last column inserted) 
TEST_COLUMN_NAMES=c(FEATURES_NAMES, "subject", "activity")

#Setting TEST column names
names(TEST)=TEST_COLUMN_NAMES

#writing the TEST file containing 2947 obs. of 563 variables
#file_position=paste(start_directory, "/", "UCI HAR Dataset", "/", "Output", sep = "")
#write.table(x = TEST, file = paste(file_position, "/", "TEST_TIDY.txt", sep=""), append = FALSE, col.names = TRUE, row.names = FALSE)

#TRAIN_DATASET---------------------------------------------------------------------------------------------------------

#Importing TRAIN dataset, formed by 7352 rows
file_position = paste(start_directory, "/", "UCI HAR Dataset", "/", "train", "/", "X_train.txt", sep = "")
TRAIN=readLines(con = file_position)

#Substituting double spaces with spaces. After that every row of TRAIN is formed by numbers separated by a single space
TRAIN=gsub(pattern = "  ", replacement = " ", x = TRAIN)

#Splitting every row of TRAIN in 562 single elements (TRAIN becomes a list)
TRAIN=strsplit(x = TRAIN, split = " ")

#Eliminating the first element of each row of the list (an empty element)
TRAIN=lapply(X = TRAIN, FUN = Eliminate_first)

#Checking that the length of every TRAIN element is actually 562-1 = 561 
length_vector=sapply(X = TRAIN, FUN = length)
length_vector[length_vector!=561]

#Changing the class of every atomic element of TRAIN in numeric
TRAIN=lapply(X = TRAIN, FUN = as.numeric)

#Chaging TRAIN from class list to class data frame
TRAIN=as.data.frame(TRAIN)

#TRAIN is transposed (final result: 7352 obs x 561 variables)
TRAIN=as.data.frame(t(TRAIN))

#For every observation there are data of the 561 features (e.g. "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", ...)

#Importing SUBJECT_TRAIN data set, formed by 7352 obs, and setting it as a data frame
file_position = paste(start_directory, "/", "UCI HAR Dataset", "/", "train", "/", "subject_train.txt", sep = "")
SUBJECT_TRAIN=as.data.frame(read.table(file = file_position, header = FALSE))

#Importing ACTIVITY_TRAIN data set, formed by 2947 obs, and setting it as a data frame
file_position = paste(start_directory, "/", "UCI HAR Dataset", "/", "train", "/", "y_train.txt", sep = "")
ACTIVITY_TRAIN=read.table(file = file_position, header = FALSE)
ACTIVITY_TRAIN=sapply(X = ACTIVITY_TRAIN, FUN = as.character)

#Substituting activity number with descriptive activity names
ACTIVITY_TRAIN=gsub(pattern = "1", replacement = "walking", x = ACTIVITY_TRAIN)
ACTIVITY_TRAIN=gsub(pattern = "2", replacement = "walking upstairs", x = ACTIVITY_TRAIN)
ACTIVITY_TRAIN=gsub(pattern = "3", replacement = "walking downstairs", x = ACTIVITY_TRAIN)
ACTIVITY_TRAIN=gsub(pattern = "4", replacement = "sitting", x = ACTIVITY_TRAIN)
ACTIVITY_TRAIN=gsub(pattern = "5", replacement = "standing", x = ACTIVITY_TRAIN)
ACTIVITY_TRAIN=gsub(pattern = "6", replacement = "laying", x = ACTIVITY_TRAIN)

ACTIVITY_TRAIN=as.data.frame(ACTIVITY_TRAIN)

#Enriching TRAIN with the subject and the activity information
TRAIN=cbind(TRAIN, SUBJECT_TRAIN, ACTIVITY_TRAIN)

#Setting TRAIN column names (the same as TEST's data set)
names(TRAIN)=TEST_COLUMN_NAMES

#writing the TRAIN file containing 7352 obs. of 563 variables
#file_position=paste(start_directory, "/", "UCI HAR Dataset", "/", "Output", sep = "")
#write.table(x = TRAIN, file = paste(file_position, "/", "TRAIN_TIDY.txt", sep=""), append = FALSE, col.names = TRUE, row.names = FALSE)

#Merging TEST and TRAIN data sets; the result contains 10299 obs. of 563 variables--------------------------------------------------------------------------
Merged_dataset=rbind(TEST, TRAIN)
#file_position=paste(start_directory, "/", "UCI HAR Dataset", "/", "Output", sep = "")
#write.table(x = Merged_dataset, file = paste(file_position, "/", "Merged_dataset.txt", sep=""), append = FALSE, col.names = TRUE, row.names = FALSE)

#Selecting the columns which names contain "mean()" or "std()" (as well as "subject" and "activity" columns), and subsetting the merged dataset with these columns; the result contains 10299 obs. of 68 variables
library(dplyr)
indexes=grep(pattern = "mean\\(\\)|std\\(\\)|subject|activity", x = names(Merged_dataset))
Subset_Merged_dataset=Merged_dataset[, indexes]
Subset_Merged_dataset$subject=as.factor(Subset_Merged_dataset$subject)
Subset_Merged_dataset=as.tbl(Subset_Merged_dataset)
#file_position=paste(start_directory, "/", "UCI HAR Dataset", "/", "Output", sep = "")
#write.table(x = Subset_Merged_dataset, file = paste(file_position, "/", "Subset_Merged_dataset.txt", sep=""), append = FALSE, col.names = TRUE, row.names = FALSE)

#Grouping the subset of the merged dataset by subject and activity, calculating the average of each variable; the result contains 180 obs. of 68 variables
Subset_Merged_dataset=group_by(Subset_Merged_dataset, subject, activity)
output_dataset=summarize_all(.tbl = Subset_Merged_dataset, .funs = mean)
file_position=paste(start_directory, "/", "UCI HAR Dataset", "/", "Output", sep = "")
write.table(x = output_dataset, file = paste(file_position, "/", "Output_dataset.txt", sep=""), append = FALSE, col.names = TRUE, row.names = FALSE)