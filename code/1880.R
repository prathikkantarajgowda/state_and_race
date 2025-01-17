# state population data 1880 (NHGIS)
# manually doing age may be untenable ATM? done here but it takes too long

library(tidyverse)

state_1880 <- 
  read_csv("data/1880/nhgis0045_ds25_1880_state.csv") %>% 
  as_tibble() %>%
  transmute(year = YEAR, state = STATE,
            
            # encoding scheme is gender_race_slavestatus_age
            # we want specific data on race, gender, and slave status
            # we want cumulative data on white pop, black pop, and slave pop
            
            male_white_NA_NA = AR0001 + AR0003,
            female_white_NA_NA = AR0002 + AR0004,
            male_black_NA_NA = AR0005 + AR0007,
            female_black_NA_NA = AR0006 + AR0008,
            
            male_chinesejapanese_NA_NA = AR0009 + AR0011,
            female_chinesejapanese_NA_NA = AR0010 + AR0012,
            male_native_NA_NA = AR0013 + AR0015,
            female_native_NA_NA = AR0014 + AR0016
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
            year = 1880,
            statistic = "population",
            value,
            source = "NHGIS2021;",
            notes = "generated by Prathik's R project here: https://github.com/prathikkantarajgowda/state",
            personentered = "Prathik", 
            complete = "")