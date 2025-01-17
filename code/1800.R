# state population data 1800 (NHGIS)
# - no age data
# - no sex data for non whites
# - we have race x slave status data for coloreds, but their def of colored does
#   not include natives. thus I have also included raw white/colored pop stats
#   to harmonize

library(tidyverse)

state_1800 <- 
  read_csv("data/1800/nhgis0029_ds2_1800_state.csv") %>% 
  as_tibble() %>%
  transmute(year = YEAR, state = STATE,
            
            # encoding scheme is gender_race_slavestatus_religion
            # we want specific data on race, gender, and slave status
            # we want cumulative data on white pop, colored pop, and slave pop
            
            male_white_NA_NA = AA0001, # white male population
            female_white_NA_NA = AA0002, # white female population
            
            NA_nonwhiteexcludingnatives_free_NA = AAY001, # free colored population (not including natives)
            NA_nonwhiteexcludingnatives_slave_NA = AAY002, # slave colored population (not including natives)
            
            NA_white_NA_NA = AAT001,# white population
            NA_nonwhite_NA_NA = AAT002, # colored population (includes natives)
            NA_nonwhiteexcludingnatives_NA_NA = AAY001 + AAY002
            ) %>% 
  pivot_longer(cols = -c("state", "year"),
               names_to = c("sex", "race", "slave_status", "age"),
               names_sep = "_",
               values_to = "value") %>%
  transmute(country = "United States", 
            state,
            sex, 
            race,
            slave_status,
            age, 
            year = 1800, 
            statistic = "population",
            value,
            source = "NHGIS2021;",
            notes = "generated by Prathik's R project here: https://github.com/prathikkantarajgowda/state",
            personentered = "Prathik", 
            complete = "yes")
