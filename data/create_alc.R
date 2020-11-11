# ==============================================================================
# _ data:
# downloaded from https://archive.ics.uci.edu/ml/datasets/Student+Performance.
# 
# Jopi J. W. Mikkonen
# 12th November 2020
# ==============================================================================

# Clear environment and load libraries
rm(list=ls())
library(dplyr)

# Global constants
PROJECT_DIR <- getwd()
DATA_FOLDER <- paste(PROJECT_DIR, "/data", sep="")

# ==============================================================================
# MAIN SCRIPT
# ==============================================================================

# Read in all the student survey data
setwd(DATA_FOLDER)
mat_data <- read.csv("student-mat.csv", sep=";", header = TRUE)
por_data <- read.csv("student-por.csv", sep=";", header = TRUE)
setwd(PROJECT_DIR)

# Take a look at the data
head(mat_data)
head(por_data)

# Show the structure of the data frame
str(mat_data)
str(por_data)

# Show the dimensions of the data frame
dim(mat_data)
dim(por_data)


# Joining the datasets 'mat' and 'por'
join_by = c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet")
joined_data <- inner_join(
  mat_data, por_data, 
  join_by,
  suffix = c(".mat", ".por")
  )

# Take a look at the joinet dataset
head(joined_data)
str(joined_data)
dim(joined_data)

# Combining the duplicate answers
# create a new data frame with only the joined columns
alc_data <- select(joined_data, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(mat_data)[!colnames(mat_data) %in% join_by]

# print out the columns not used for joining
# notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'joined_data' with the same original name
  two_columns_of_the_same_name <- select(joined_data, starts_with(column_name))
  # select the first column vector of those two columns
  first_twin_column <- select(two_columns_of_the_same_name, 1)[[1]]
  
  if(is.numeric(first_twin_column)) {
    # If the columns are numeric, take a rounded averages of the values
    alc_data[column_name] <- round(rowMeans(two_columns_of_the_same_name))
  } else {
    # If the columns are not numeric, just take the values from the first
    alc_data[column_name] <- select(two_columns_of_the_same_name, 1)[[1]]
  }
}

# Averaging the consumption data to a new column
alc_data <- mutate(alc_data, alc_use = (Dalc + Walc) / 2)

# Creating a column indicatin high alcohol use
alc_data <- mutate(alc_data, high_use = alc_use > 2)

# Final check
glimpse(alc_data) # Should have 382 observations and 35 variables

# Writing the joined data into the 'data' folder under the name of 'alc.csv'
# setwd(DATA_FOLDER)
# write.csv(alc_data, file = "alc.csv", row.names = FALSE)
write.csv(alc_data, file = "./data/alc.csv", row.names = FALSE)

# Demonstrating the data file reading
# data_from_file <- read.csv("alc.csv", header = TRUE)
# head(data_from_file)
# str(data_from_file)
# dim(data_from_file)

# setwd(PROJECT_DIR)

# ==============================================================================
# FOR TESTING ONLY
# ==============================================================================

# Read and examine the example data
example_alc <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/alc.txt ", sep=",", header=TRUE)
glimpse(example_alc)
glimpse(alc_data)
