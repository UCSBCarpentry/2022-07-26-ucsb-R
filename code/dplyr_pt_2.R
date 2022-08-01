library(tidyverse)
library(palmerpenguins)

data(penguins)

## Challenge (last time):

# Create a new data frame from the penguins data that 
# meets the following criteria: contains only the species 
# column and a new column called flipper_length_cm 
# containing the length of the penguin flipper values 
# (currently in mm) converted to centimeters. In this 
# flipper_length_cm column, there are no NAs and all 
# values are less than 20. Hint: think about how the 
# commands should be ordered to produce this data frame!

# Solution (not the only way)
# First, make a new column (mutate)
# Second, filter out NAs and just keep values less than 20
# Third, select only species and the new column

penguin_flippers <- penguins %>%
  mutate(flipper_length_cm = flipper_length_mm / 10) %>%
  filter(!is.na(flipper_length_cm), flipper_length_cm < 20) %>%
  select(species, flipper_length_cm)
penguin_flippers

## Split-apply-combine (making summaries)

penguins %>% 
  group_by(sex) %>% # groups will be new observational units
  summarize(mean_body_mass_g = mean(body_mass_g)) # make new column(s)
# in a new data frame
penguins %>%
  group_by(sex, species) %>%
  summarize(mean_body_mass_g = mean(body_mass_g))

# experimental; not really standard, just for fun
penguins %>%
  group_by(sex, species) %>%
  mutate(mean_body_mass_g = mean(body_mass_g)) %>%
  view()

penguins %>%
  filter(is.na(sex)) %>%
  view()

penguins %>%
  filter(!is.na(body_mass_g)) %>%
  group_by(sex, species) %>%
  summarize(mean_body_mass_g = mean(body_mass_g),
            min_body_mass_g = min(body_mass_g),
            num_penguins = n()) %>%
  view()

penguins %>%
  drop_na() %>% # drops any incomplete cases (rows w/ any NA's)
  group_by(sex, species) %>%
  summarize(mean_body_mass_g = mean(body_mass_g),
            min_body_mass_g = min(body_mass_g),
            num_penguins = n()) %>%
  view()

## Challenge:

# 1. How many penguins are in each island surveyed?

penguins %>% 
  group_by(island) %>% 
  summarise(num_penguins = n()) 

penguins %>%
  count(island) %>%
  rename(num_penguins = n)
#   
# 2. Use group_by() and summarize() to find the mean, 
#    min, and max bill length for each species (using species). 
#    Also add the number of observations (hint: see ?n).

penguins %>%
  filter(!is.na(bill_length_mm)) %>%
  group_by(species) %>%
  summarize(min_bill = min(bill_length_mm),
            max_bill = max(bill_length_mm),
            mean_bill = mean(bill_length_mm),
            num_penguins = n())
# 
# 3. What was the heaviest animal measured in each year? 
#    Return the columns year, island, species, and body_mass_g.
 
penguins %>%
  filter(!is.na(body_mass_g)) %>%
  group_by(year) %>%
  filter(body_mass_g == max(body_mass_g)) %>%
  select(year, island, species, body_mass_g)

