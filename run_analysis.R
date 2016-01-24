# Getting and Cleaning Data - COurse Project

# Create one R script called run_analysis.R that does the following:

# 1. Merges the training and the test sets to create one data set.

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# 3. Uses descriptive activity names to name the activities in the data set

# 4. Appropriately labels the data set with descriptive activity names.

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

require("data.table")
require("reshape2")

# get the activity labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# get the column names
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Extract only the measurements on the mean and standard deviation for each measurement.
mean_sd_features <- grepl("mean|std", features)

# Load and process X_test & y_test data.
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(x_test) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
x_test = x_test[,mean_sd_features]

# Load activity labels
y_test[,2] = activityLabels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# Bind data
test_data <- cbind(as.data.table(subject_test), y_test, x_test)

# Load and process x_train & y_train data.
x_train <- read.table("UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

names(x_train) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
x_train = x_train[,mean_sd_features]

# Get activity data
y_train[,2] = activityLabels[y_train[,1]]
# descriptive activity names
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# Column bind data
train_data <- cbind(as.data.table(subject_train), y_train, x_train)

# Merge test and train data
data = rbind(test_data, train_data)

# descriptive activity names
id_labels = c("Subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data = melt(data, id = id_labels, measure.vars = data_labels)

# Use dcast to apply mean
tidy_data = dcast(melt_data, Subject + Activity_Label ~ variable, mean)

# Create tidy data file
write.table(tidy_data, file = "tidy_data.txt")
