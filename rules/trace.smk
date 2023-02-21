rule trace:
    input:
        "results/model/chains.tsv"
    output:
        "results/figs/trace.png"
    log:
        "results/logs/trace.log"
    benchmark:
        "results/benchmarks/trace.benchmark.txt"
    params:
        n_pars=config["n_pars"],
        dpi=config["dpi"],
        width=config["width"],
        height=config["height"]
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/trace.R"
