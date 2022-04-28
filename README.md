# sta-304
# 1. Overview
The code in this replication packages constructs our analysis using R Studio. There are three figures in this project. All figures are originals. All the steps are done by R Studio. The following packages is needed before running the code:
library(opendatatoronto)
library(dplyr)
library(tidyverse)
library(patchwork)
library(ggplot2)

# Data Availability and Provenance Statements
## 2.1 Statement about Rights.
We certify that the authors of the manuscript have legitimate access to and permission to use the data used in this manuscript.
## 2.2 Summary of Availability
All data in the replication package is available here

auto_thefts <- read_csv('auto_thefts.csv')
neighbourhood <- read_csv('neighbourhood_profiles_2016.csv')

# 3. Instruction and Code
Here are the instructions and codes to replicate the graph.

## Codes for Figure.1a:
auto_thefts <- auto_thefts                                                 # Replicate original data
auto_thefts$occurrencemonth <- factor(auto_thefts$occurrencemonth,                                        # Change ordering manually
                  levels = c("January", "February", "March", "April", "May",
                   "June", "July", "August", "September", "October", 
                   "November", "December"))

ggplot(auto_thefts) +
  aes(x = occurrencemonth) +
  geom_bar(fill = "lightblue") +
  labs(x = "Occurrence month", title="Fig.1a: Distribution of occurrences in terms of month") 
  
## Codes for Figure.1b:
auto_thefts <- auto_thefts                                                 # Replicate original data # Change ordering manually
auto_thefts$occurrencedayofweek <- factor(auto_thefts$occurrencedayofweek,                              
                    levels = c("Monday", "Tuesday", "Wednesday", "Thursday",
                    "Friday", "Saturday", "Sunday"))
ggplot(auto_thefts) +
  aes(x = occurrencedayofweek) +
  geom_bar(fill = "darkseagreen3") + 
  labs(x = "Occurrence Day of Week", title="Fig.1b: Distribution of occurrences in terms of days in a week")
## Codes for Figure.1c:
ggplot(auto_thefts) +
  aes(x = occurrencehour) +
  geom_bar(fill = "darkslategrey") +
  geom_vline(xintercept = 5.5, color = 'blue') +
  geom_vline(xintercept = 17.5, color = 'blue') + 
  labs(x = "Occurrence hour", title="Fig.1c: Distribution of occurrences in terms of hours in a day")
  
## Codes for Figure.1d:
ggplot(auto_thefts) +
  aes(x = premisetype) +
  geom_bar(fill = "lightpink") + 
  labs(x = "Premise Type", title="Fig.1d: Distribution of occurrences in terms of premise type")
  
## Codes for Figure.2:
ggplot(auto_thefts) +
  aes(x = Long, y = Lat, colour = Division) +
  geom_point(alpha = 0.05) +
  ggtitle('Fig.2: Frequency of Occurrences in Divisions')
  
## Codes for Figure.3a:
ggplot(neighbourhood) +
  aes(x = area, y = n) +
  geom_point() + ggtitle('Fig.3a: Relationship between area of neighbourhoods and occurrences') + theme(plot.title = element_text(size = 12))

## Codes for Figure.3b:
ggplot(neighbourhood) +
  aes(x = area, y = n) +
  geom_point() + 
  ggtitle('Fig.3b: Linear regression model between area of neighbourhoods and occurrences') +
  geom_smooth(method='lm', se=FALSE)
  
## Codes for Figure.3c:
neighbourhood_2 <- neighbourhood %>%
  filter(area <= 20)

ggplot(data = neighbourhood_2, aes(x = area, y = n)) +
  geom_point() +
  ggtitle('Fig.3c: Enhanced linear regression model between area of neighbourhoods and occurrences') +
  geom_smooth(method = 'lm', se = FALSE)
