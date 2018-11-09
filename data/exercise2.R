# Author: Teppo Lindfors
# Date: 9.11.2018
# IODS: Exercise 2


##########################################################################################
##########################################################################################
##########################################################################################
# Q2. Reading and exploring data
lrn2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",
                            sep = "\t", header = T)
str(lrn2014)
head(lrn2014)
# The data appears to be in the form of a dataframe of dimension 183x60, i.e., 
# it consists of 183 observations and 60 different variables.

##########################################################################################
# Q3. Extracting a dataset for analysis
# Installing necessary packages
library(dplyr)

# Adding a composite index of deep, surface and strategic learning to the dataset
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_cols <- select(lrn2014, one_of(deep_questions))
lrn2014$deep <- rowMeans(deep_cols)

surf_cols <- select(lrn2014, one_of(surface_questions))
lrn2014$surf <- rowMeans(surf_cols)

stra_cols <- select(lrn2014, one_of(strategic_questions))
lrn2014$stra <- rowMeans(stra_cols)

# Picking variables from the full dataset for further analysis
lrn2014a <- lrn2014 %>%
  select(gender, Age, Attitude, deep, surf, stra, Points) %>%
  filter(Points != 0)

# Checking whether the extraction worked
str(lrn2014a)

##########################################################################################
# Q4. Setting a new working directory
setwd("C:/Users/Teppo/Documents/GitHub/IODS-project")

# Saving the analysis dataset as a csv-file
write.csv(lrn2014a, "lrn2014a.csv")

# Rereading the analysis dataset as a demonstration
lrn2014a_demo <- read.csv("lrn2014a.csv", row.names = 1)
str(lrn2014a_demo)
head(lrn2014a_demo)

