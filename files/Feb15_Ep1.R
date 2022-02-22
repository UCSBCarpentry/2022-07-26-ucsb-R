## Episode 1: Intro to Rstudio
# 1)Datatypes in Rstudio
# 2)Assigning values to variables of different data types
# 3)Extracting subsets from vectors
# 4)Missing values in R

##Objects in Rstudio
# Rstudio as a calculator
3+5
12/7

##Assigning variables in R
# <- vs = 
# we use <- because = is used in mathematical functions and we should avoid confusing R

area_hectares <- 1.0
area_hectares*2.47

area_acres <- 2.47*area_hectares
area_acres

#quick question
#reassigning variables. Assigning a value to one object does not change the value of
#other objects unless specified
area_hectares <- 50 #vs area_hectares <- 1 from line 16

#area_acres = now is ??? 
area_acres <- 2.47*area_hectares

#Challenge 
#create two variables r_length and r_width
#create new varibale r_area and give it a value based on r_length and r_width 

r_length <- 5.5
r_width <- 4
r_area <- r_length*r_width

##Rounding variables
b <- sqrt(a)
a = 9

round(3.14159)

#you can add a second option to specify the number of digits to round to
round(3.14159, digits = 2)

##Vectors and Data Types 
#vector: most common and basic data type in R
#composed of a series of values, can be numbers or characters

#assign household members the following values using combine, c()
hh_members <- c(3,7,10, 6)
hh_members

#length() will tell you how many elements are in a particular vector
length(hh_members)

##Subsetting 
#Extracting one or several values from a vector using indices
# or square brackets []

#Assign respondent wall type the following values
respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")
respondent_wall_type

#finding a certain item in a list
respondent_wall_type[2]

respondent_wall_type[c(3,2)]

##Conditional subsetting
#Use logical vectors to subset data (TRUE and FALSE)

#if a value is a conditional (true/false)
hh_members[c(TRUE, FALSE, TRUE, FALSE)]

#this command below is asking for which households have households
#greater than 5 members
hh_members > 5

##Missing Data 
#Not all data is complete, what to do with missing values in a dataset
#Most numerical datasets will return NA if missing data
#Use 'na.rm = TRUE' to calculate results while ignoring missing values 

#Assign following to rooms variable
rooms <- c(2,1,1,NA,7)
mean(rooms)
max(rooms)
#In this case, mean and max are NA because there is an NA in the dataset
#this can throw off your data analysis so we must ignore or omit the NA

rooms[!is.na(rooms)]
#!is.na will return the values that at NOT na from your data set 

sum(!is.na(rooms))
# this will count the number 

#Quick Exercise
rooms <- c(1, 2, 1, 1, NA, 3, 1, 3, 2, 1, 1, 8, 3, 1, NA, 1)

#1) What is the command to find the median of this list?
#2) How would I find the number of households with more than 2 rooms?

rooms_na <- rooms[!is.na(rooms)]
rooms_na  
median(rooms_na)

sum(rooms_na > 2)
#sum in a boolean argument will get a "count" of the number of items
#count will not, because of the datatype. rooms_na is a numberic and count 
#is for dataframes (later episode)