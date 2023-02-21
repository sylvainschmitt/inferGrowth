# snakemake log
log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

# snakemake vars
in_file <- snakemake@input[[1]]
out_file <- snakemake@output[[1]]

# libraries
library(vroom)
library(tidyverse)

vroom(in_file) %>% 
  group_by(idTree) %>% 
  mutate(Year = CensusYear - min(CensusYear)) %>%
  ungroup() %>% 
  mutate(ind = as.numeric(as.factor(as.character(idTree)))) %>% 
  mutate(sp = as.numeric(as.factor(species))) %>% 
  vroom_write(out_file)
