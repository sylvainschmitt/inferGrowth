rule prep_draws:
    input:
        "results/model/chains.tsv"
    output:
        "results/model/draws.tsv"
    log:
        "results/logs/prep_draws.log"
    benchmark:
        "results/benchmarks/prep_draws.benchmark.txt"
    params:
        quantilespars=config["quantiles"]
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/prep_draws.R"
        