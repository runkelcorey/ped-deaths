#############
#Cleaning file
#2018 Pedestrian Deaths
#Corey Runkel
#############

#libraries
library(tidyverse)
library(haven)

#import accident file
accident <- read_sas("data/accident.sas7bdat") %>%
  filter(PEDS > 0) %>% #keep entries with 1 or more ped involved
  select(STATE, ST_CASE, VE_FORMS, COUNTY:MINUTE, TWAY_ID:LONGITUD) #keep identifiers, no. of vehicles, no. of peds, time and place locators
#import person file
person <- read_sas("data/person.sas7bdat") %>%
  filter(PER_TYP == 5, INJ_SEV == 4, VEH_NO == 0) %>% #keep only pedestrians who were killed
  select(ST_CASE, PER_NO, AGE, SEX, RACE, HISPANIC)

#merge files
peds <- inner_join(accident, person)
rm(accident, person)
