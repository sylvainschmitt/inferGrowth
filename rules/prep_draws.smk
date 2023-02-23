rule prep_draws:
    input:
        "results/model/chains.tsv"
    output:
        "results/model/draws.tsv"
    log:
        "results/logs/prep_draws.log"
    benchmark:
        "results/benchmarks/prep_draws.benchmark.txt"
    singularity: 
        "https://github.com/sylvainschmitt/singularity-r-bioinfo/releases/download/0.0.3/sylvainschmitt-singularity-r-bioinfo.latest.sif"
    params:
        quantilespars=config["quantiles"]
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/prep_draws.R"
        