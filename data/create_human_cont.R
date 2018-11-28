# Author: Teppo Lindfors
# Date: 27.11.2018
# IODS: Exercise 5

##########################################################################################
##########################################################################################
##############################################################################
# Preparation: Reading and exploring the data

library(data.table)
setwd("C:/Users/Teppo/Documents/GitHub/IODS-project/data")
human <- fread("human.csv", header = T, drop = 1)

str(human)
dim(human)
head(human$gni)

# The dataset I am working with consists of 195 observations and 19 variables.
# The observations are countries, and the variables are various indicators
# of economic and social development. Apart from self-evident cases, a
# variable description is provided below:
# hdirank = country's rank according to the human development index
# lifeexp = life expectancy at birth
# eduexp = expected years of education
# edu = mean years of education
# diffrank = rank in gni per capita minus rank in hdi
# giirank = country's rank according to the gender inequality index
# mmor = maternal mortality ratio
# adobirth = adolescent birth rate
# frep = female representation in parliament
# f2edu = proportion of secondary education, female
# m2edu = proportion of secondary education, male
# fprate = labour force participation rate, female
# mprate = labour force participation rate, male
# eduratio = f2edu / m2edu
# prateratio = fprate / mprate

##########################################################################################
# Q1. Mutating data
library(stringr)
human <- human %>%
  mutate(gni = str_replace(gni, ",", "")) %>%
  mutate(gni = as.numeric(gni))

str(human)

##########################################################################################
# Q2. Mutating data
keep <- c("country", "eduratio", "prateratio", "eduexp", "lifexp", "gni",
          "mmor", "adobirth", "frep")
human <- human %>%
  select(one_of(keep))

str(human)

##########################################################################################
# Q3. Removing missing values
human <- human %>%
  filter(complete.cases(human))

str(human)

##########################################################################################
# Q4. Excluding regions
last <- nrow(human) - 7
human <- human[1:last,]

str(human)

##########################################################################################
# Q5. Defining row names and saving

rownames(human) <- human$country

human <- human %>%
  select(-country)

str(human)
write.csv(human, "human2.csv", row.names = T)

##########################################################################################
