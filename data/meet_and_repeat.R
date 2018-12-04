# Author: Teppo Lindfors
# Date: 2.12.2018
# IODS: Exercise 6

##########################################################################################
##########################################################################################
##############################################################################
# Q1. Reading and exploring data

#Packages
library(data.table)
library(dplyr)
library(tidyr)

bprs <- fread("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt") 
rats <- fread("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", drop = 1)

str(bprs)
str(rats)

dim(bprs)
dim(rats)

summary(bprs)
summary(rats)

##########################################################################################
# Q2. Categorical variables to factors
bprs$treatment <- factor(bprs$treatment) 
bprs$subject <- factor(bprs$subject)

rats$ID <- factor(rats$ID)
rats$Group <- factor(rats$Group)

##########################################################################################
# Q3. From wide to long
bprsl <- bprs %>%
  gather(week, bprs, week0:week8)

ratsl <- rats %>%
  gather(Time, Weight, WD1:WD64)

##########################################################################################
# Q4. Comparison between wide and long
names(bprsl)
names(ratsl)

str(bprsl)
str(ratsl)

summary(bprsl)
summary(ratsl)

# In the long form, each variable is assigned to its own column. This
# is often referred to as the tidy data form, a standard way to
# arrange data preceding analysis.

write.csv(bprsl, "bprsl.csv")
write.csv(ratsl, "ratsl.csv")
