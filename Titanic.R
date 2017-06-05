# Step 0: Loading the data into R

setwd("~/SpringBoard/Data Wrangling Exercise 2 - Dealing with missing values")
library(tidyverse)
titanic_original <- read.csv("titanic_original.csv",  stringsAsFactors = FALSE)
titanic <- tbl_df(titanic_original)

# Step 1: Set Missing embard locations to S
for(i in 1:length(titanic$embarked)) {
  if(is.na(titanic$embarked[i]) | is.null(trimws(titanic$embarked[i])) | trimws(titanic$embarked[i]) == "")
     titanic$embarked[i] <- "S"
}

# Step 2: FIlling missing age with mean of age

meanage <- mean(titanic$age, na.rm = TRUE)

for(i in 1:length(titanic$age)) {
  if(is.na(titanic$age[i]) | is.null(trimws(titanic$age[i])) | trimws(titanic$age[i]) == "")
    titanic$age[i] <- meanage
}

# Step 3: FIll missing boat column with "None"
for(i in 1:length(titanic$boat)) {
  if(trimws(titanic$boat[i]) == "")
    titanic$boat[i] <- "None"
}

# Step 4: Check for cabin number

titanic <- titanic %>% 
  mutate(has_cabin_number = ifelse(is.null(trimws(cabin)) | trimws(cabin) == "", 0, 1))

# Step 5: Write output to new csv

write.csv(titanic, file = "titanic_clean.csv")

View(titanic)