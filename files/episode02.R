# Episode 2, Starting with Data

library(tidyverse)
library(here)

here() # tells you the file path

here("data", "SAFI_clean.csv")

interviews <- read_csv(
  here("data", "SAFI_clean.csv"),
  na = "NULL"
)

interviews
glimpse(interviews)
view(interviews)

# Inspect properties of the data frame (tibble)

dim(interviews)
n_rows <- nrow(interviews)
ncol(interviews)

head(interviews)
tail(interviews)

names(interviews)
str(n_rows)
str(interviews)
summary(interviews)

# Indexing and subsetting data frames

interviews[1, 1]
interviews[1, 2]
interviews[[1]] # first column of tibble as vector
str(interviews[[1]])
interviews[1] # first column of tibble as a tibble

interviews[1:3, 7] # first 3 rows, 7th column
interviews[1:5, 6:8]

interviews[3, ] # row 3, all the columns
interviews[, 7] # all the rows, 7th column

head(interviews)
head_interviews <- interviews[1:6, ]

# Leaving things out

interviews[ , -1] # all rows, exclude first column
interviews[-c(7:131), ] # exclude rows 7 to 131, all the columns

interviews["village"]
interviews[["village"]]
all_the_villages <- interviews[["village"]]
all_members <- interviews[["no_membrs"]]

interviews[["notaname"]]

interviews$village # village column as a vector

# exercise solutions:

interviews_100 <- interviews[100,]
n_rows <- nrow(interviews)
interviews[n_rows, ]
tail(interviews)
interviews_last <- interviews[n_rows, ]

n_rows/2
round(n_rows/2)
trunc(n_rows/2)
interviews[trunc(n_rows/2), ]

# Factors on Thursday!
