# Last Time:
## Pipes, factors, packages, select, filter, mutate, count, group_by
## summarize

library(tidyverse)
library(here)

?select # chooses columns (given their names or indexes)
?filter # chooses rows (based on some expression)

interviews_plotting <- read_csv("http://math.westmont.edu/data/interviews_plotting.csv")
## You can make this yourself using the episode 3.

View(interviews_plotting)

## ggplot2 is part of the tidyverse

## gg stands for Grammar of Graphics

## DATA >>> 
##   AESTHETIC MAPPING: how the the data correspond to the graph?
##   GEOMETRY: What shapes, etc. do we want to plot?

# A first example:

interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) + 
  geom_point(alpha = 0.1)

interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_jitter(width = 0.2, height = 0.2, alpha = 0.4)

interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items, color = village)) +
  geom_count()

## Exercise:
## create a scatter plot of rooms by village (rooms on vertical
## axis and village on horizontal) with the respondent_wall_type 
## showing in different colors.

interviews_plotting %>% 
  ggplot(aes(x = village, y = rooms, color = respondent_wall_type)) +
  geom_count() +
  scale_color_viridis_d() # change the color scheme
# kind of a trick question: this is not really a good way to plot
# categorical variables.

## Comparing groups: Boxplots

interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(aes(color = village),width = 0.3, height = 0.1,
              alpha = 0.5)

interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(width = 0.3, height = 0.1,
              alpha = 0.5, color = "tomato")

## Exercises:
## 1. Repeat the above plot, but use geom_violin
## instead of geom_jitter. What do you thing geom_violin 
## is doing?
interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type, y = rooms)) +
  geom_violin(alpha = 0) +
  geom_jitter(width = 0.3, height = 0.1,
              alpha = 0.5, color = "tomato")

##
## 2. Create a boxplot for liv_count for each wall type. 
## Overlay the boxplot layer on a jitter layer to show 
## actual measurements.

interviews_plotting %>% 
  ggplot(aes(x = respondent_wall_type, y = liv_count)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(width = 0.2, height = 0.1, alpha = 0.3)

##
## 3. Add colour to the data points on your boxplot 
## from #2 according to whether the respondent is a member of 
## an irrigation association (memb_assoc).

# right way:
interviews_plotting %>% 
  ggplot(aes(x = respondent_wall_type, y = liv_count)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(aes(color = memb_assoc), width = 0.2, height = 0.1, alpha = 0.3)

# slightly wrong way:
interviews_plotting %>% 
  ggplot(aes(x = respondent_wall_type, y = liv_count, color = memb_assoc)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(width = 0.2, height = 0.1, alpha = 0.3)


## Bar Plots

interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type)) +
  geom_bar(aes(fill = village), position = "dodge")

percent_wall_type <- interviews_plotting %>%
  filter(respondent_wall_type != "cement") %>%
  count(village, respondent_wall_type) %>%
  group_by(village) %>%
  mutate(percent = (n / sum(n)) * 100) %>%
  ungroup()

percent_wall_type %>%
  ggplot(aes(x = village, y = percent, fill = respondent_wall_type)) +
  geom_bar(stat = "identity", position = "dodge")

## or equivalently
percent_wall_type %>%
  ggplot(aes(x = village, y = percent, fill = respondent_wall_type)) +
  geom_col(position = "dodge")

## Exercise:
## Create a bar plot showing the proportion of respondents 
## in each village who are or are not part of an irrigation 
## association (memb_assoc). Include only respondents who 
## answered that question in the calculations and plot. 
## Which village had the lowest proportion of respondents in 
## an irrigation association?

percent_memb_assoc <- interviews_plotting %>%
  filter(!is.na(memb_assoc)) %>%
  count(village, memb_assoc) %>%
  group_by(village) %>%
  mutate(percent = (n / sum(n)) * 100) %>%
  ungroup()

percent_memb_assoc %>%
  ggplot(aes(x = village, y = percent, fill = memb_assoc)) +
  geom_col(position = "dodge")

## Labels and Titles

percent_wall_type %>%
  ggplot(aes(x = village, y = percent, fill = respondent_wall_type)) +
  geom_col(position = "dodge") +
  labs(title = "Proportion of wall type by village",
       fill = "Type of Wall in Home",
       x = "Village",
       y = "Percent")

## Faceting

percent_wall_type %>%
  ggplot(aes(x = respondent_wall_type, y = percent)) +
  geom_col(position = "dodge") +
  facet_wrap(~ village) +  # facet by village
  theme_bw()

## Exercise:
## Experiment with at least two different themes. 
## Build the previous plot using each of those themes.

percent_wall_type %>%
  ggplot(aes(x = respondent_wall_type, y = percent)) +
  geom_col(position = "dodge") +
  facet_wrap(~ village) +  # facet by village
  theme_linedraw()

percent_wall_type %>%
  ggplot(aes(x = respondent_wall_type, y = percent)) +
  geom_col(position = "dodge") +
  facet_wrap(~ village) +  # facet by village
  theme_classic()

## Customizations

percent_wall_type %>%
  ggplot(aes(x = respondent_wall_type, y = percent)) +
  geom_col(position = "dodge") +
  facet_wrap(~ village) +  # facet by village
  labs(title = "Wall type distribution by village",
       x = "Type of Wall in Home",
       y = "Percent") +
  theme_linedraw() + 
  theme(axis.text.x = element_text(size = 10,
                                   angle = 45,
                                   hjust = 0.9))

my_theme <- theme_linedraw() + 
  theme(axis.text.x = element_text(size = 10,
                                   angle = 45,
                                   hjust = 0.9))

percent_wall_type %>%
  ggplot(aes(x = respondent_wall_type, y = percent)) +
  geom_col(position = "dodge") +
  facet_wrap(~ village) +  # facet by village
  labs(title = "Wall type distribution by village",
       x = "Type of Wall in Home",
       y = "Percent") +
  my_theme

my_plot <- percent_wall_type %>%
  ggplot(aes(x = respondent_wall_type, y = percent)) +
  geom_col(position = "dodge") +
  facet_wrap(~ village) +  # facet by village
  labs(title = "Wall type distribution by village",
       x = "Type of Wall in Home",
       y = "Percent") +
  my_theme

## Saving plots

ggsave(here("fig_output", "my_plot.png"), my_plot,
       width = 8, height = 6)
