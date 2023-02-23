rule prep_chains:
    input:
        expand("results/model/chain-{chain}.csv", chain=range(1,config["chains"]+1))
    output:
        expand("results/model/chain-{chain}.tsv", chain=range(1,config["chains"]+1))
    log:
        "results/logs/prep_chains.log"
    benchmark:
        "results/benchmarks/prep_chains.benchmark.txt"
    singularity: 
        "docker://ghcr.io/jbris/stan-cmdstanr-docker:latest"
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/prep_chains.R"
        