# state population data 1910 (ICPSR 02896)

library(tidyverse)
library(haven)

state_1910 <- 
  read_dta("data/1910/DS0022/02896-0022-Data.dta") %>% 
  as_tibble() %>% 
  filter(level == 2) %>% 
  transmute(name,
          # race x sex (ONLY FOR WHITES AND blackS). we are lacking race x sex
          # data for other coloreds, so our data is technically incomplete
          male_white_NA_NA = wmtot,
          female_white_NA_NA = wftot,
          male_black_NA_NA = negmtot,
          female_black_NA_NA = negftot,
          NA_nonwhiteorblack_NA_NA = othraces,
) %>% 
  pivot_longer(cols = -c(name),
               names_to = c("sex", "race", "slave_status", "age"),
               names_sep = "_",
               values_to = "value") %>% 
  transmute(country = "United States", 
            state = name,
            sex,
            race,
            slave_status,
            age,
            year = 1910,
            statistic = "population",
            value,
            source = "Haines2010;",
            notes = "generated by Prathik's R project here: https://github.com/prathikkantarajgowda/state",
            personentered = "Prathik", 
            complete = "yes")