# Author:      Sternophant
# Date:        2015-08-17

# Description:
# Step 1 - Read raw data
# Step 2 - Add descriptive variable names
# Step 3 - Merge data
# Step 4 - Extratc mean() and std() variables
# Step 5 - Create a second, independent tidy data set 
#          with the average of each variable for each activity and each subject


library(dplyr)

# Step 1 - Read raw data
# -----------------------------------------------------------------------------

# Features and activity_labels
activity_labels_path <- file.path("UCI HAR Dataset", "activity_labels.txt")
activity_labels      <- read.table(file = activity_labels_path,
                                   colClasses = c("numeric", "character"))

features_path <- file.path("UCI HAR Dataset", "features.txt")
features      <- read.table(file = features_path,
                            colClasses = "character")

# Test raw data
subject_test_path <- file.path("UCI HAR Dataset","test", "subject_test.txt")
subject_test      <- read.table(file = subject_test_path,
                                colClasses = "numeric")

X_test_path <- file.path("UCI HAR Dataset","test", "X_test.txt")
X_test      <- read.table(file = X_test_path,
                          colClasses = "numeric")

y_test_path <- file.path("UCI HAR Dataset","test", "y_test.txt")
y_test      <- read.table(file = y_test_path,
                          colClasses = "numeric")

# Train raw data
subject_train_path <- file.path("UCI HAR Dataset","train", "subject_train.txt")
subject_train      <- read.table(file = subject_train_path,
                                 colClasses = "numeric")

X_train_path <- file.path("UCI HAR Dataset","train", "X_train.txt")
X_train      <- read.table(file = X_train_path,
                           colClasses = "numeric")

y_train_path <- file.path("UCI HAR Dataset","train", "y_train.txt")
y_train      <- read.table(file = y_train_path,
                          colClasses = "numeric")

# Remove unrequired variabes from environment
rm(activity_labels_path,
   features_path,
   subject_test_path,
   X_test_path,
   y_test_path,
   subject_train_path,
   X_train_path,
   y_train_path)

# -----------------------------------------------------------------------------


# Step 2 - Add descriptive variable names
# -----------------------------------------------------------------------------
colnames(activity_labels) <- c("activity", "activity_label") 

colnames(subject_test)  <- "subject"
colnames(subject_train) <- "subject"

colnames(X_test)  <- features[ , 2]
colnames(X_train) <- features[ , 2]

colnames(y_test)  <- "activity"
colnames(y_train) <- "activity"
# -----------------------------------------------------------------------------


# Step 3 - Merge data
# -----------------------------------------------------------------------------

# Add activity_labels
y_test  <- left_join(y_test, activity_labels)
y_train <- left_join(y_train, activity_labels)

# Merge columns of "subject_*", "y_*", and "X_* seperately for test and train data
test <-  bind_cols(subject_test, y_test, X_test)
train <- bind_cols(subject_train, y_train, X_train)

# Merge test and train data
data <- rbind(test, train)

# Remove duplicate data from workspace
rm(activity_labels, features, 
   subject_test, y_test, X_test, 
   subject_train, y_train, X_train, test, train)
# -----------------------------------------------------------------------------


# Step 4 - Extratc mean() and std() variables
# -----------------------------------------------------------------------------
index_subject_activity <- c(1:3)
index_mean             <- grep("mean()", names(data), fixed = T)
index_std              <- grep("std()", names(data), fixed = T)
index_columns          <- c(index_subject_activity, index_mean, index_std)
index_columns          <- sort(index_columns)

data_mean_std          <- data[ , index_columns] %>% arrange(subject, activity)

# Remove unrequired variables from environment
rm(index_subject_activity,
   index_mean,
   index_std,
   index_columns)
# -----------------------------------------------------------------------------


# Step 5 - Create a second, independent tidy data set 
#          with the average of each variable for each activity and each subject
# -----------------------------------------------------------------------------
averaged_data_mean_std <- data_mean_std %>%
  group_by(subject, activity, activity_label) %>% 
  summarise_each(funs(mean))

names(averaged_data_mean_std)[4:69] <- paste("mean_of_", 
                                             names(averaged_data_mean_std)[4:69], 
                                             sep = "")
# -----------------------------------------------------------------------------