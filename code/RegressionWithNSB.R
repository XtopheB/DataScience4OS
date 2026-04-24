# Regression modelling with NSB
# Paro

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

# Step 2: Exploring the data 
summary(Mydata)

# Changing the type of Sex variable

MydataNew  <- Mydata %>%
  mutate( sexF = as.factor(sexF), 
          education_level  = as.factor(education_level), 
          age_group = case_when(
            age <20 ~ "young",
            age >= 20 & age <40 ~"middle", 
            age >= 40 ~"senior")
          )

# Descriptive analysis
datasummary_skim(Mydata,
                 type = "numeric",
                 title = "Numerical variables descriptive statistics"
                 )

datasummary_skim(Mydata,
                 type = "categorical")


# Selecting only variables of interest

Mydata <- Mydata %>%
  select(income, age, education, education_level, sexF)

# Graphics with the help of esquisse package
# Basic plot

Mydata %>%
  ggplot()+
    aes(x = education, y = income)+
    geom_point(colour = "#112446") +
    theme_minimal()

#plot by facet

ggplot(Mydata) +
  aes(x = education, y = income) +
  geom_point(colour = "#112446") +
  labs(title = " Income vs Education", 
       caption = "Data from 2026") +
  theme_minimal() +
  facet_wrap(vars(sexF))

#plot by facet

GraphIncomeBySex <- ggplot(Mydata) +
  aes(x = education, y = income, colour = sexF) +
  geom_point() +
  scale_color_hue(direction = 1) +
  theme_minimal() +
  facet_wrap(vars(sexF))

GraphIncomeBySex

# Prefered way of coding with example
Mydata %>%
  mutate(agecat = as.factor(ifelse(age> 40, "senior", "young")))%>%
  ggplot()+
  aes(x = education, y = income)+
  geom_point(colour = "#112446") +
  facet_wrap(vars(agecat))+
  theme_minimal()

# Regression

modeluni <- lm(data = Mydata,
               income~education)
# Results 
summary(modeluni)

# Nice formating of results
modelsummary(modeluni,
             stars =TRUE)

# Another model
modelmulti <-lm(data = Mydata,
                income~education + sexF + education_level) 

summary(modelmulti)

modelmultiwithage <-lm(data = Mydata,
                income~education + sexF + education_level + age) 


modelmultiSex <-lm(data = Mydata,
                       income~education + sexF +  age) 


modelmultiwithageNew <-lm(data = MydataNew,
                       income~education + sexF + education_level + age_group) 

#compare models
modelsummary(list(modeluni, modelmulti, modelmultiwithage, modelmultiwithageNew), 
             stars =TRUE)
