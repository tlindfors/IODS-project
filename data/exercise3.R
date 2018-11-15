# Author: Teppo Lindfors
# Date: 14.11.2018
# IODS: Exercise 3

##########################################################################################
##########################################################################################
##########################################################################################
# Q3. Reading and exploring data
setwd("C:/Users/Teppo/Documents/GitHub/IODS-project/data")

library(data.table)
smat <- fread("student-mat.csv")
spor <- fread("student-por.csv")

str(smat)
str(spor)

# Student-mat dataset includes overall 395 observations and 33 variables, while
# student-por dataset consists of 649 observations and 33 variables.

##########################################################################################
# Q4. Joining the datasets
id <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu",
        "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet")

library(dplyr)
jdata <- inner_join(smat, spor, by = id)
str(jdata)

# The joined dataset has 382 observations and 53 variables.

##########################################################################################
# Q5. Dealing with duplicates

# Creating a for loop, which takes the average of numeric duplicate answers,
# and settles with the other answer in case of string duplicates.

alc <- select(jdata, one_of(id))
notjoinedcols <- colnames(smat)[!colnames(smat) %in% id]

for(column_name in notjoinedcols) {
  
  two_columns <- select(jdata, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    
    alc[column_name] <- round(rowMeans(two_columns))
  
    } else { 
      
    alc[column_name] <- first_column
  
    }
}

##########################################################################################
# Q6. Crearing variables alc_use and high_use

alc <- alc %>%
  mutate(alc_use = (Dalc + Walc) / 2) %>%
  mutate(high_use = alc_use > 2)

##########################################################################################
# Q7. Checking and saving

glimpse(alc)
write.csv(alc, "alc.csv")

