#### Preamble ####
# Purpose: Clean Raw Data
# Author: Yiyi Ren
# Data: 27 April 2022
# Contact: yiyi.ren@utoronto.ca 
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the auto thefts data and saved it to inputs/data


#### Workspace setup ####
# Use R Projects, not setwd().
library(haven)
library(tidyverse)
# Read in the raw data. 
auto_thefts <- read_csv('auto_thefts.csv')
neighbourhood <- read_csv('neighbourhood_profiles_2016.csv')

# Just keep some variables that may be of interest
days = 1:7
names(days) <- c("Monday", "Tuesday", "Wednesday", "Thursday",
                 "Friday", "Saturday", "Sunday")

months = 1:12
names(months) <- c("January", "February", "March", "April", "May",
                   "June", "July", "August", "September", "October",
                   "November", "December")

auto_thefts <- read_csv('auto_thefts.csv') %>%
  mutate(occurrencedayofweekn = days[occurrencedayofweek],
         reporteddayofweekn = days[reporteddayofweek],
         occurencemonthn = months[occurrencemonth],
         reportedmonthn = months[reportedmonth],
         hours_diff = (reportedhour - occurrencehour) +
           (reporteddayofyear - occurrencedayofyear) * 24 +
           (reportedyear - occurrenceyear) * 24 * 365,
         is_night = occurrencehour < 6 | occurrencehour >= 18)

neighbourhood <- read_csv('neighbourhood_profiles_2016.csv') %>%
  mutate(area = pop_2016 / pop_density_per_square_km)

joined <- left_join(auto_thefts, neighbourhood, by = 'Hood_ID')

n_neighbourhood <- joined %>%
  group_by(Hood_ID) %>%
  summarize(n = n())

neighbourhood <- left_join(neighbourhood, n_neighbourhood, by = 'Hood_ID')

auto_thefts <- auto_thefts %>%
  filter(occurrencemonth == "January" | occurrencemonth == "February" | 
           occurrencemonth == "March" | occurrencemonth == "April"| 
           occurrencemonth == "May" | occurrencemonth == "June"| 
           occurrencemonth == "July" | occurrencemonth == "August"| 
           occurrencemonth == "September" | occurrencemonth == "October"| 
           occurrencemonth == "November" | occurrencemonth == "December")



         