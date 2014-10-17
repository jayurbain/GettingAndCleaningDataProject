# Jay Urbain, 10/16/2014
# jay.urbain@gmail.com
#
# Functionality: run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
# Application flow:
# 1) Download data, if necessary
# 2) Read activities, features, and identify mean and std feature columns
# 3) Read and prepare test data
# 4) Read and prepare training data
# 5) Merge test and training data
# 6) Write tidy data set to "tidy_data.txt"

if (!require("data.table")) {
  install.packages("data.table")
}
require("data.table")

# Download data function
# Examines current working directory for data subdirectory. If it does not
# exist, it initiates a download of the smartphone dataset.
# "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.data = function() {
  # Checks for data directory and creates one if it does not exist
  if (!file.exists("data")) {
    message("Creating data directory")
    dir.create("data")
  }
  if (!file.exists("data/UCI HAR Dataset")) {
    # download the data
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zipfile="data/UCI_HAR_data.zip"
    message("Downloading data")
    download.file(fileURL, destfile=zipfile, method="curl")
    unzip(zipfile, exdir="data")
  }
}

##########################################################
# 0) Download data, if necessary
download.data()

##########################################################
# 2) Read activities and features
# Read activities
activities <- read.table("data/UCI HAR Dataset/activity_labels.txt")[,2]

# Read features (column names)
features <- read.table("data/UCI HAR Dataset/features.txt")[,2]

# Extract only the measurements for mean and standard deviation for each measurement.
mean_std_features <- grep("mean|std", features, ignore.case = TRUE)

##########################################################
# Read and prepare test data.
X_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
names(X_test) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
X_test = X_test[,mean_std_features]

# Set activity and subject names
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity")
names(subject_test) = "Subject"

# Bind test data
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

##########################################################
# 4) Read and prepare training data
X_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
names(X_train) = features

# Extract only the measurements for mean and standard deviation.
X_train = X_train[,mean_std_features]

# Load activity data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity")
names(subject_train) = "Subject"

# Bind training data
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

##########################################################
# 5) Merge test and training data
data = rbind(test_data, train_data)

##########################################################
# 6) Write tidy data set to "tidy_data.txt"
write.table(data, file = "tidy_data.txt")


