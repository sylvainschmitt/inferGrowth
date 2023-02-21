# snakemake log
log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

# snakemake vars
in_file <- snakemake@input[[1]]
out_file <- snakemake@output[[1]]
n_census <- as.numeric(snakemake@params$n_census)
n_years <- as.numeric(snakemake@params$n_years)
n_ind_species <- as.numeric(snakemake@params$n_ind_species)
filter_data <- snakemake@params$filter_data
n_sp_max <- as.numeric(snakemake@params$n_sp_max)
n_ind_sp_max <- as.numeric(snakemake@params$n_ind_sp_max)

# test
# in_file <- "snakemake/data/guyafor.csv"
# n_census <- 10
# n_years <- 30
# n_ind_species <- 6
# filter_data <- TRUE
# n_sp_max <- 5
# n_ind_sp_max <- 5

# libraries
library(vroom)
library(tidyverse)

# code
trees <- vroom(in_file,
      locale=locale(decimal_mark=',')) %>% 
  mutate(species = paste(Genus, Species)) %>% 
  filter(!grepl("Indet", species)) %>% 
  filter(BotaSource == "Bota") %>% 
  group_by(idTree) %>% 
  arrange(CensusYear) %>% 
  mutate(FirstDead = first(CensusYear[CodeAlive == 0])) %>% 
  mutate(FirstDead = ifelse(is.na(FirstDead), max(CensusYear)+1, FirstDead)) %>% 
  filter(CensusYear < FirstDead) %>% 
  ungroup() %>% 
  mutate(DBH = CircCorr/pi) %>%
  group_by(Plot) %>% 
  mutate(StartYear = min(CensusYear)) %>% 
  group_by(idTree) %>% 
  arrange(CensusYear) %>% 
  filter(first(CensusYear) > StartYear) %>% 
  filter(first(DBH) < 15) %>%
  filter(last(DBH) > first(DBH)) %>%
  group_by(idTree) %>% 
  filter((max(CensusYear) - min(CensusYear)) >= n_years) %>% 
  filter(n() >= n_census) %>% 
  group_by(species) %>% 
  filter(length(unique(idTree)) >= n_ind_species) %>% 
  ungroup()
if(filter_data)
  trees <- dplyr::select(trees, species, idTree) %>% 
    unique() %>% 
    filter(species %in% sample(unique(trees$species), n_sp_max)) %>% 
    group_by(species) %>% 
    sample_n(n_ind_sp_max, replace = T) %>%
    unique() %>% 
    ungroup() %>% 
    left_join(trees)
vroom_write(trees, out_file)
