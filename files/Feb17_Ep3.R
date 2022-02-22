## Episode 3: Data Wrangling 
# 1)How to select specific rows and columns from a dataframe
# 2)Combining multiple commands by nesting, preferably piping
# 3)Reformating dataframe for your needs

library(tidyverse)
library(here)

interviews <- read_csv(here("data", "SAFI_clean.csv"), na = "NULL")

#utilizing messy data by:
#selecting, filtering, mutating, grouping/summarizing, arranging, counting

##Selecting Columns and Filtering Rows


#To select columns from a dataframe - tidy way
select(interviews, village, no_membrs, months_lack_food)

#subsetting by column name using the combine command will
#also have the same output - base R way
interviews[c("village",  "no_membrs", "months_lack_food")]

#to select a series of connected columns, treating them like a vector


## Filtering 
#first example filter out chirodzo
# == is an equality test, not an assignment 
filter(interviews, village == "Chirodzo")

#using multiple conditional statements to filter through messy data
filter(interviews, village == "Chirodzo", rooms > 1, no_meals> 2)

#using AND statements would be same as ^
# 'And' would be used to find all observations that meet EVERY criteria of the argument
filter(interviews, village == "Chirodzo" & 
         rooms > 1 & 
         no_meals > 2)

#using OR statement - the bar is not a lower-case L, number 1, or a pipe
#OR would be used where observations must meet one fo the specified conditions.
filter(interviews, village == "Chirodzo" | village == "Ruaca")


##Pipes 
#Taking the output of one command and using it as the input
#in a new second command
#Think of the krispykreme donut conveyor belt

#how to do it through multiple commands
#first filter out all observations of chirodzo into a new datafram
interviews2 <- filter(interviews, village == "Chirodzo")

#columns through village 
#then, select the columns from village to walltype
interviews_ch <- select(interviews2, village:respondent_wall_type)

#how to use nested functions to get the same output as ^ but harder to read
interviews_ch <- select(filter(interviews, village =="Chirodzo"),
                        village:respondent_wall_type)

#how to use pipes to avoid ^ and ^^. A cleaner command!
interviews %>% 
  filter(village == "Chirodzo") %>% 
  select(village:respondent_wall_type)

#piping doesn't automatically create new dataframes 
interviews_pipe <- interviews %>% 
  filter(village == "Chirodzo") %>% 
  select(village:respondent_wall_type)
interviews_pipe

#Challenge Question
#subset the interviews data to include views where respondents were
#members of an irrigation association (memb_assoc) and 
#retain only the columns affect_conflicts, liv_count, and no_meals.
#3 min

interviews %>%
  filter(memb_assoc == "yes") %>% #filter out those who answered yes or no
  select(affect_conflicts, liv_count, no_meals) #select specified columns


##Mutate: create new columns based on values from existing columns
#Ex: finding ratio of values in different columns, or unit conversions

#creating a new column where we find a ratio of hh members to rooms
interviews %>% 
  mutate(people_per_room = no_membrs/rooms) %>% #this is a statement 
  view() 

#will first filter out data from our dataset where the respondent didn’t answer 
#the question of whether they were a member of an irrigation association. 
#These cases are recorded as “NULL” in the dataset. We only want records of their status

interviews %>% 
  filter(!is.na(memb_assoc)) %>%
  mutate(people_per_room = no_membrs/rooms) %>%
  view()

  
#Challenge Question
#Create a new dataframe that meets the following criteria:
# 1) contains only village column and new column 'total_meals'
# 2) total_meals is a new column that equals meals served per hhold per day on average
# 3) only rows where total meals is greater than 20 should be in the final dataframe
interview_meals <- interviews %>%
  mutate(total_meals = no_membrs * no_meals) %>%
  filter(total_meals > 20) %>%
  select(village, total_meals) %>% #mutate must come first but filter/select either order
view

##Summarizing: 
#groupby: takes arguments as column names that contain categorical values 
#summarize: collapses groups into single row 

#calculate average household size by village
interviews %>% 
  group_by(village) %>%
  summarize(mean_no_membrs = mean(no_membrs))

#grouping by multiple columns
interviews %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs))

#ungrouping grouped tibbles - if necessary
interviews %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs)) %>%
  ungroup()

#summarizing multiple variables at the same time
#add a new column for min household size for each group
interviews %>% 
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs), 
            min_membrs = min(no_membrs))

#arrange(min_membrs) #arrange by smallest hh first
interviews %>% 
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs), 
            min_membrs = min(no_membrs)) %>%
  arrange(min_membrs)

#arrange(desc(min_membrs))#arrange in descending order
interviews %>% 
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs), 
            min_membrs = min(no_membrs)) %>%
  arrange(desc(min_membrs))#arrange in descending order

##Counting
#to find the number of observations for each factor or combination of factors
interviews %>%
  count(village)

#instead of arrange or desc, we use sort (which is an argument in the sort command)
interviews %>%
  count(village, sort = TRUE)

#Challenge Question
#1) How many households have an av 2 meals per day? 3 meals? 
interviews %>%
  count(no_meals)

#2) Use group_by and summarize to find mean, min, and max number
#   of hh members of each village and the number of obs
interviews %>%
  group_by(village) %>%
  summarize(
    mean_no_membrs = mean(no_membrs),
    min_no_membrs = min(no_membrs),
    max_no_membrs = max(no_membrs),
    n = n()
  )

## Using lubridate 
#This is the third part of the challenge we did not go over
#Here is the demo code
#3) What is the largest household interviewed in each month?

library(lubridate) #will need to install and load 

interviews %>%
  mutate(month = month(interview_date), #create new columns for month, day, year
         day = day(interview_date),
         year = year(interview_date)) %>%
  group_by(year, month) %>%             # pipe new column output into groups by month and year
  summarize(max_no_membrs = max(no_membrs)) # summarize the maximum number of members by month/year 
view()
