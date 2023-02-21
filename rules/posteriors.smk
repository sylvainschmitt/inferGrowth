rule posteriors:
    input:
        "results/model/draws.tsv"
    output:
        "results/figs/posteriors.png"
    log:
        "results/logs/posteriors.log"
    benchmark:
        "results/benchmarks/posteriors.benchmark.txt"
    params:
        n_posteriors=config["n_posteriors"],
        dpi=config["dpi"],
        width=config["width"],
        height=config["height"],
        quant_post=config["quant_post"]
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/posteriors.R"
