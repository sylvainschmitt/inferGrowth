# snakemake log
log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

# snakemake vars
chains <- snakemake@input[[1]]
out <- snakemake@output[[1]]
n_pars <- snakemake@params$n_pars
dpi <- snakemake@params$dpi
width <- snakemake@params$width
height <- snakemake@params$height

# test
# chains <- c("snakemake/results/model/chains.tsv")
# n_pars <- 2

# libraries
library(tidyverse)
library(vroom)
library(viridis)
library(bayesplot)

# code
theme_set(bayesplot::theme_default())
t <- vroom(chains) %>% 
  separate(parameter, c("type", "id"), sep = "\\[", remove = FALSE) %>% 
  mutate(id = as.numeric(gsub("]", "", id))) %>% 
  mutate(id = ifelse(is.na(id), 0, id))
g <- t %>% 
  select(type, id) %>% 
  unique() %>% 
  group_by(type) %>% 
  sample_n(n_pars, replace = T) %>% 
  unique() %>% 
  left_join(t) %>% 
  ggplot(aes(iteration, value, col = as.factor(chain))) +
  geom_line() +
  facet_wrap(~ parameter, scales = "free_y") + 
  viridis::scale_color_viridis(discrete = T, guide = "none")
ggsave(g, file = out, dpi = dpi, width = width, height = height)
  