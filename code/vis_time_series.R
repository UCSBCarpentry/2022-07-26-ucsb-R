# Time Series Visualization
## plotting "Date Egg" of penguins_raw

# load required packages
library(lubridate)

library(tidyverse)

library(palmerpenguins)

# load data into the environment
data(penguins)

# using a subset of the raw data such that we only get observations from November 2008
penguins_raw_subset <- penguins_raw %>%
  select("Island", "Species", "Date Egg", "Island") %>%
  filter(year(penguins_raw[["Date Egg"]]) == 2008) %>%
  rename(date_egg = "Date Egg")

# create tibble/table of egg counts per day for each species
daily_counts <- penguins_raw_subset %>%
  count(date_egg, Species)

View(daily_counts)

# this plot is inaccurate bc counts are seperated by species
# the plot must account for the species grouping
ggplot(data = daily_counts, aes(x = date_egg, y = n)) +
  geom_line()

# color code lines by species
ggplot(data = daily_counts, aes(x = date_egg, y = n, color = Species)) +
  geom_line()

# adjust the scale of the x-axis
# parameters specify the new scale as ticks labeled every two days(date_breaks), and only showing the day (date_labels)
ggplot(data = daily_counts, aes(x = date_egg, y = n, color = Species)) +
  geom_line() + 
  scale_x_date(date_labels="%d", date_breaks  ="2 days")

# add in points to clearly display where observations are
# add more informative titles
ggplot(data = daily_counts, aes(x = date_egg, y = n, color = Species)) +
  geom_line() + 
  geom_point() +
  scale_x_date(date_labels="%d", date_breaks  ="2 days") +
  labs(title = "Counts of observed Eggs in November",
       x = "Date in November",
       y = "Egg Counts")

# Do the same for island:
daily_island_counts <- penguins_raw_subset %>%
  count(date_egg, Island)

ggplot(data = daily_island_counts, aes(x = date_egg, y = n, color = Island)) +
  geom_line() + 
  geom_point() +
  scale_x_date(date_labels="%d", date_breaks  ="2 days") +
  labs(title = "Counts of observed Eggs in November",
       x = "Date in November",
       y = "Egg Counts")
