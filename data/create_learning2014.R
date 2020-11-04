# ==============================================================================
# IODS 2020 exercise 2 data wrangling - regression and model validation
# Data from https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt
# 
# Jopi J. W. Mikkonen
# 5th November 2020
# ==============================================================================

lrn14 <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# lrn14

str(lrn14)
dim(lrn14)

# Alternative to the above, for testing only
students14 <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=",", header=TRUE)
str(students14)
dim(students14)
