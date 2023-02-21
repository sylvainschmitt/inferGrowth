# snakemake log
log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

# snakemake vars
chains <- snakemake@input[[1]]
out <- snakemake@output[[1]]

# test
# chains_in <- c("snakemake/results/model/chain-1.tsv", "snakemake/results/model/chain-2.tsv")

# libraries
library(tidyverse)
library(vroom)
library(posterior)

# code
vroom(chains) %>% 
  spread(chain, value) %>% 
  select(-iteration) %>% 
  group_by(parameter) %>% 
  do(m = as.matrix(select(., -parameter))) %>% 
  mutate(m = rhat(m)) %>% 
  vroom_write(out)
  