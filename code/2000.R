# state population data 2000 (NHGIS)

library(tidyverse)

state_2000 <- 
  read_csv("data/2000/nhgis0042_ds146_2000_state.csv") %>% 
  as_tibble() %>%
  mutate(year = YEAR, state = STATE) %>% 
  pivot_longer(cols = starts_with("FM1"),
               names_to = "demographic") %>%
  mutate(demographic = (parse_number(substr(demographic, 4, 6))),
         age_num = demographic %% 23,
         gender_num = demographic %% 46,
         race_num = demographic / 46) %>%
  transmute(country = "United States", 
            state,
            sex = ifelse(gender_num == 0 | gender_num > 23,
                            "female", "male"),
            race = case_when(race_num <= 1 ~ "white",
                             race_num <= 2 ~ "black",
                             race_num <= 6 ~ "nonwhiteorblack",
                             race_num <= 7 ~ "multiracial"),
            slave_status = "NA",
            age = case_when(age_num == 0 ~ "85_and_over",
                            age_num == 1 ~ "0_to_4",
                            age_num == 2 ~ "5_to_9",
                            age_num == 3 ~ "10_to_14",
                            age_num == 4 ~ "15_to_17",
                            age_num == 5 ~ "18_to_19",
                            age_num == 6 ~ "20",
                            age_num == 7 ~ "21",
                            age_num == 8 ~ "22_to_24",
                            age_num == 9 ~ "25_to_29",
                            age_num == 10 ~ "30_to_34",
                            age_num == 11 ~ "35_to_39",
                            age_num == 12 ~ "40_to_44",
                            age_num == 13 ~ "45_to_49",
                            age_num == 14 ~ "50_to_54",
                            age_num == 15 ~ "55_to_59",
                            age_num == 16 ~ "60_to_61",
                            age_num == 17 ~ "62_to_64",
                            age_num == 18 ~ "65_to_66",
                            age_num == 19 ~ "67_to_69",
                            age_num == 20 ~ "70_to_74",
                            age_num == 21 ~ "75_to_79",
                            age_num == 22 ~ "80_to_84"),
            year = 2000,
            statistic = "population",
            value,
            source = "NHGIS2021;",
            notes = "generated by Prathik's R project here: https://github.com/prathikkantarajgowda/state",
            personentered = "Prathik", 
            complete = "")