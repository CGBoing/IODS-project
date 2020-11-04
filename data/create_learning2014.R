# ==============================================================================
# Creating a data file from original data:
# Data from https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt
# 
# Jopi J. W. Mikkonen
# 5th November 2020
# ==============================================================================

# Clear environment and load libraries
rm(list=ls())
library(dplyr)

# ==============================================================================
# HELPER VARIABLES
# ==============================================================================

PROJECT_DIR <- getwd()
DATA_FOLDER <- paste(PROJECT_DIR, "/data", sep="")

# ==============================================================================
# MAIN SCRIPT
# ==============================================================================

# Read in all the student survey data
learning14 <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header = TRUE)

# Take a look at the data
head(learning14)

# Show the structure of the data frame
str(learning14)

# Show the dimensions of the data frame
dim(learning14) # Should be 183 rows and 60 columns

# Creating new data frame using combination variables
lrn14 = data.frame(
  gender   
    = learning14$gender,
  age      
    = learning14$Age,
  attitude 
    = rowMeans(select(learning14, one_of(c("Da", "Db", "Dc", "Dd", "De", "Df", "Dg", "Dh", "Di", "Dj")))),
  deep     
    = rowMeans(select(learning14, one_of(c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06", "D15", "D23", "D31")))),
  stra     
    = rowMeans(select(learning14, one_of(c("ST01", "ST09", "ST17", "ST25", "ST04", "ST12", "ST20", "ST28")))),
  surf     
    = rowMeans(select(learning14, one_of(c("SU02", "SU10", "SU18", "SU26", "SU05", "SU13", "SU21", "SU29", "SU08", "SU16", "SU24", "SU32")))),
  points   
    = rowMeans(select(learning14, one_of(c("Points"))))
  )

# head(lrn14)

# Filtering out the zero-point objects
lrn14 <- filter(lrn14, points > 0)

# Writing the wrangled data into the 'data' folder under the name of 'learning2014.csv'
setwd(DATA_FOLDER)

write.csv(lrn14, file = "learning2014.csv", row.names = FALSE)

# Demonstrating the data file reading
test <- read.csv("learning2014.csv", header = TRUE)
head(test)
str(test)
dim(test)

setwd(PROJECT_DIR)

# ==============================================================================
# FOR TESTING ONLY
# ==============================================================================

# Read and examine the example data
test14 <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=",", header=TRUE)
str(test14)
dim(test14) # Should be 166 rows and 7 columns
head(test14)