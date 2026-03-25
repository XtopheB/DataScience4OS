# Regression modelling with NSB
# Paro

# Seting up the working directory
setwd("C:/GitMain/DataScience4OS/code")

# load some packages 
library(haven)   # if we need to load Excel , Stat, files...
library(tidyverse)  # Data Science package

# Step1: Load the data
Mydata <- read.csv("../Data/Household.csv")

# Data feature
str(Mydata)
head(Mydata)
names(Mydata)

# Step 2: Exploring the data 
summary(Mydata)

# Changing the type of Sex variable

Mydata  <- Mydata %>%
  mutate( sexF = as.factor(sex), 
          education_level  = as.factor(education_level)
          )





