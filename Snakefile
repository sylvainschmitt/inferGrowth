configfile: "config/config_test.yml"

rule all:
   input:
        "results/report/report_prep.html",
        "results/model/chains.tsv",
        "results/model/draws.tsv",
        "results/report/report.html"

# Rules #

## prepare
include: "rules/filter_trees.smk"
include: "rules/prep_mdata.smk"
include: "rules/report_prep.smk"

## run ##
include: "rules/sample.smk"
include: "rules/prep_chains.smk"
include: "rules/extract_pars.smk"
include: "rules/prep_draws.smk"

## post ##
include: "rules/rhat.smk"
include: "rules/trace.smk"
include: "rules/pairs.smk"
include: "rules/posteriors.smk"
# include: "rules/phylogeney.smk"
include: "rules/report.smk"
