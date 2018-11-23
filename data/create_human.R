# Author: Teppo Lindfors
# Date: 23.11.2018
# IODS: Exercise 4

##########################################################################################
##########################################################################################
##############################################################################
# Q2. Reading and exploring data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

##########################################################################################
# Q3. Structure, dimensions, summaries
str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)

##########################################################################################
# Q4. Renaming variables
colnames(hd)
hd <- hd %>%
  rename(hdirank = HDI.Rank, country = Country,
         hdi = Human.Development.Index..HDI.,
         lifexp = Life.Expectancy.at.Birth,
         eduexp = Expected.Years.of.Education,
         edu = Mean.Years.of.Education,
         gni = Gross.National.Income..GNI..per.Capita,
         diffrank = GNI.per.Capita.Rank.Minus.HDI.Rank)
colnames(gii)
gii <- gii %>%
  rename(giirank = GII.Rank, country = Country,
         gineq = Gender.Inequality.Index..GII.,
         mmor = Maternal.Mortality.Ratio,
         adobirth = Adolescent.Birth.Rate,
         frep = Percent.Representation.in.Parliament,
         f2edu = Population.with.Secondary.Education..Female.,
         m2edu = Population.with.Secondary.Education..Male.,
         fprate = Labour.Force.Participation.Rate..Female.,
         mprate = Labour.Force.Participation.Rate..Male.)

##########################################################################################
# Q5. Creating new variables
gii <- gii %>%
  mutate(eduratio = f2edu / m2edu, prateratio = fprate / mprate)

##########################################################################################
# Q6. Joining and saving
human <- hd %>%
  inner_join(gii, by = "country")

str(human)
setwd("C:/Users/Teppo/Documents/GitHub/IODS-project/data")
write.csv(human, "human.csv")

