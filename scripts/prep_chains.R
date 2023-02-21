# snakemake log
log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

# snakemake vars
chains_in <- snakemake@input
chains_out <- snakemake@output

# libraries
library(tidyverse)
library(cmdstanr)

# code
for(i in 1:length(chains_in)){
  fit <- read_cmdstan_csv(chains_in[[i]])
  draws <- drop(fit$post_warmup_draws) %>% 
    as_data_frame() %>% 
    mutate(iteration = 1:n()) %>% 
    gather(parameter, value, -iteration)
  vroom::vroom_write(draws, file = chains_out[[i]])
  rm(fit, draws)
  gc()
}
