rule pairs:
    input:
        "results/model/chains.tsv"
    output:
        "results/figs/pairs.png"
    log:
        "results/logs/pairs.log"
    benchmark:
        "results/benchmarks/pairs.benchmark.txt"
    params:
        n_pars=config["n_pars"],
        dpi=config["dpi"],
        width=config["width"],
        height=config["height"]
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/pairs.R"
