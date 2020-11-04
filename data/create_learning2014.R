# ==============================================================================
# IODS 2020 exercise 2 data wrangling - regression and model validation
# Data from https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt
# 
# Jopi J. W. Mikkonen
# 5th November 2020
# ==============================================================================

# ==============================================================================
# HELPER VARIABLES
# ==============================================================================

PROJECT_DIR <- getwd()
DATA_FOLDER <- paste(PROJECT_DIR, "/data", sep="")

# ==============================================================================
# MAIN SCRIPT
# ==============================================================================

lrn14 <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Take a look at the data
lrn14

# Show the structure of the data frame
str(lrn14)

# Show the dimensions of the data frame
dim(lrn14) # Should be _ rows and _ columns

setwd(DATA_FOLDER)

write.csv(lrn14, file = "learning2014.csv")
test <- read.csv("learning2014.csv")
test
str(test)

setwd(PROJECT_DIR)

# ==============================================================================
# FOR TESTING ONLY
# ==============================================================================

# students14 <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=",", header=TRUE)
# str(students14)
# dim(students14) # Should be 166 rows and 7 columns
