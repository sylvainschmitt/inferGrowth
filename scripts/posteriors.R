# snakemake log
log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

# snakemake vars
draws <- snakemake@input[[1]]
out <- snakemake@output[[1]]
n_posteriors <- snakemake@params$n_posteriors
quant_post <- snakemake@params$quant_post
dpi <- snakemake@params$dpi
width <- snakemake@params$width
height <- snakemake@params$height

# test
# draws <- c("snakemake/results/model/draws.tsv")
# n_posteriors <- 100
# quant_post <- c(0.05, 0.25, 0.5, 0.75, 0.95)

# libraries
library(tidyverse)
library(vroom)
library(viridis)
library(bayesplot)

# code
theme_set(bayesplot::theme_default())
if(length(quant_post) != 5)
  stop("We need 5 quantiles to draw posterior distributions.")
g <- vroom(draws) %>% 
  filter(quantile %in% quant_post) %>% 
  arrange(quantile) %>% 
  mutate(quantile = as.numeric(as.factor(quantile))) %>% 
  mutate(quantile = paste0("q", quantile)) %>% 
  spread(quantile, value) %>% 
  sample_n(n_posteriors, replace = T) %>% 
  unique() %>% 
  ggplot(aes(x = parameter, xend = parameter)) +
  geom_point(aes(y = q3), shape = 21, size = 3, alpha = 0.5) +
  geom_segment(aes(y = q1, yend = q5),
               size = 1, show.legend = F, alpha = 0.5) +
  geom_segment(aes(y = q2, yend = q4), size = 2, alpha = 0.5) +
  coord_flip() +
  scale_y_log10() +
  ylab("posterior")
ggsave(g, file = out, dpi = dpi, width = width, height = height)