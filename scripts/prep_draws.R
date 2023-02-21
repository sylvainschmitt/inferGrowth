# snakemake log
log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

# snakemake vars
chains <- snakemake@input[[1]]
draws <- snakemake@output[[1]]
quantiles <- snakemake@params$quantiles

# test
# quantiles <- c(0.05, 0.25, 0.5, 0.75, 0.95)
# chains <- c("snakemake/results/model/chains.tsv")

# libraries
library(tidyverse)
library(vroom)

# code
vroom(chains) %>% 
  rowwise() %>% 
  mutate(quantile = list(quantiles)) %>% 
  unnest(quantile) %>% 
  ungroup() %>% 
  group_by(parameter, quantile) %>% 
  summarise(value = quantile(value, quantile)) %>% 
  unique() %>% 
  vroom_write(draws)
