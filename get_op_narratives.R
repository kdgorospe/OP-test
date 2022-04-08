# Author: Kelvin Gorospe
# Contact: kdgorospe@gmail.com

rm(list=ls())
library(tidyverse)
# Question for Elizabeth - hidden columns?
op_dat <- read.csv("OP-Atlasti.csv")

mangrove_dat <- op_dat %>%
  select(USAID_Bureau, IM_Names, Operating_Unit, IM_Number, Award_Numbers, IM_Narratives, SPSDs, Key_Issues) %>%
  # Only keep rows with "mangrove" in the Narrative
  filter(str_detect(string = IM_Narratives, pattern = "mangrove")) %>% 
  # Split narrative into a list of sentences and only keep sentences with "mangrove"
  mutate(IM_Narratives = str_split(IM_Narratives, pattern = "\\.")) %>%
  rowwise() %>%
  mutate(IM_Narratives = list(str_subset(IM_Narratives, pattern = "mangrove|carbon"))) %>%
  # Clean up - remove leadnig and trailing white space, add a period.
  mutate(IM_Narratives = list(str_trim(IM_Narratives))) %>%
  mutate(IM_Narratives = list(paste(IM_Narratives, ". ", sep = ""))) %>%
  mutate(IM_Narratives = list(paste(IM_Narratives, collapse = ""))) %>%
  mutate(IM_Narratives = list(str_trim(IM_Narratives))) %>%
  mutate(IM_Narratives = unlist(IM_Narratives))

write.csv(mangrove_dat, "Outputs/op_mangrove.csv", row.names = FALSE)
  
  
seagrass_dat <- op_dat %>%
  select(IM_Names, Operating_Unit, USAID_Bureau, IM_Number, Award_Numbers, IM_Narratives, SPSDs, Key_Issues) %>%
  # Only keep rows with "mangrove" in the Narrative
  filter(str_detect(string = IM_Narratives, pattern = "seagrass")) %>% 
  # Split narrative into a list of sentences and only keep sentences with "mangrove"
  mutate(IM_Narratives = str_split(IM_Narratives, pattern = "\\.")) %>%
  rowwise() %>%
  mutate(IM_Narratives = list(str_subset(IM_Narratives, pattern = "seagrass"))) %>%
  # Clean up - remove leadnig and trailing white space, add a period.
  mutate(IM_Narratives = list(str_trim(IM_Narratives))) %>%
  mutate(IM_Narratives = list(paste(IM_Narratives, ". ", sep = ""))) %>%
  mutate(IM_Narratives = list(paste(IM_Narratives, collapse = ""))) %>%
  mutate(IM_Narratives = list(str_trim(IM_Narratives))) %>%
  mutate(IM_Narratives = unlist(IM_Narratives))
  
write.csv(seagrass_dat, "Outputs/op_seagrass.csv", row.names = FALSE)
