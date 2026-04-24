# Exercise with TidyVerse
# NSB - Paro

# Seting up the working directory
setwd("C:/GitMain/DataScience4OS/code")

# load some packages 
library(haven)   # if we need to load Excel , Stat, files...
library(tidyverse)  # Data Science package
library(modelsummary)
library(esquisse)

# Step1: Load the data
Mydata <- read.csv("../Data/Household.csv")

# Data feature
str(Mydata)
head(Mydata)
names(Mydata)

# Overview
glimpse(Mydata)

# Step 2: Exploring the data 
summary(Mydata)

# Changing the type of Sex variable

Mydata <- Mydata %>%
  mutate( sexF = as.factor(sexF), 
          education_level  = as.factor(education_level), 
          age_group = case_when(
            age <20 ~ "young",
            age >= 20 & age <40 ~"middle", 
            age >= 40 ~"senior")
          )


# Selecting only variables of interest

Mydata <- Mydata %>%
  select(income, age, education, education_level, sexF)

