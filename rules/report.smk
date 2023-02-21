rule report:
    input:
        rhat="results/model/rhat.tsv",
        trace="results/figs/trace.png",
        pairs="results/figs/pairs.png",
        posteriors="results/figs/posteriors.png"
    output:
        "results/report/report.html"
    log:
        "results/logs/report.log"
    benchmark:
        "results/benchmarks/report.benchmark.txt"
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/report.Rmd"
        