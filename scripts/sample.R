# snakemake log
log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

# snakemake vars
mdataf <- snakemake@input[["mdata"]]
modelf <- snakemake@input[["model"]]
out_dir <- snakemake@output[[1]]
chains <- snakemake@params$chains
parallel_chains <- snakemake@params$parallel_chains
refresh <- snakemake@params$refresh
max_treedepth <- snakemake@params$max_treedepth
iter_warmup <- snakemake@params$iter_warmup
iter_sampling <- snakemake@params$iter_sampling
threads <- snakemake@params$threads

# libraries
library(vroom)
library(tidyverse)
library(cmdstanr)

# code
mdata <- vroom(mdataf)
growth <- cmdstan_model(modelf, cpp_options = list(stan_threads = TRUE))
if(!dir.exists(out_dir))
  dir.create(out_dir)
fit <- growth$sample(
  data = list(
    N = nrow(filter(mdata, Year > 0)),
    I = max(mdata$ind),
    S = max(mdata$sp),
    Y = max(mdata$Year),
    year = filter(mdata, Year > 0)$Year,
    dbh = filter(mdata, Year > 0)$DBH,
    dbh0 = filter(mdata, Year == 0)$DBH,
    dmax = summarise(group_by(mdata, sp), dmax = max(DBH))$dmax,
    ind = filter(mdata, Year > 0)$ind,
    indsp = arrange(unique(mdata[c("ind", "sp")]), ind)$sp,
    grainsize = 1
  ),
  output_dir = out_dir,
  output_basename = "chain",
  parallel_chains = threads,
  chains = chains, 
  threads_per_chain = parallel_chains,
  refresh = refresh,
  iter_warmup = iter_warmup,
  iter_sampling = iter_sampling,
  save_warmup = FALSE,
  max_treedepth = max_treedepth
)
