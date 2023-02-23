rule rhat:
    input:
        "results/model/chains.tsv"
    output:
        "results/model/rhat.tsv"
    log:
        "results/logs/rhat.log"
    benchmark:
        "results/benchmarks/rhat.benchmark.txt"
    singularity: 
        "docker://ghcr.io/jbris/stan-cmdstanr-docker:latest"
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/rhat.R"
        