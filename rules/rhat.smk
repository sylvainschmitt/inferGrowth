rule rhat:
    input:
        "results/model/chains.tsv"
    output:
        "results/model/rhat.tsv"
    log:
        "results/logs/rhat.log"
    benchmark:
        "results/benchmarks/rhat.benchmark.txt"
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/rhat.R"
        