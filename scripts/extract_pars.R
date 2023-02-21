# snakemake log
log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

# snakemake vars
chains_in <- snakemake@input
out <- snakemake@output[[1]]
pars <- as.character(snakemake@params$pars)
str(pars)

# test
# pars <- c("lp__", "gmax_s", "sigmaG")
# chains_in <- c("snakemake/results/model/chain-1.tsv", "snakemake/results/model/chain-2.tsv")

# libraries
library(tidyverse)
library(vroom)

# code
names(chains_in) <- 1:length(chains_in)
lapply(chains_in, vroom) %>% 
  bind_rows(.id = "chain") %>% 
  filter(grepl(paste(pars, collapse="|"), parameter)) %>% 
  vroom_write(out)
