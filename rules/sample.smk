rule sample:
    input:
        mdata="results/data/model_data.tsv",
        model=expand("model/{model}", model=config["model"])
    output:
        directory("results/model"),
        expand("results/model/chain-{chain}.csv", chain=range(1,config["chains"]+1))
    log:
        "results/logs/sample.log"
    benchmark:
        "results/benchmarks/sample.benchmark.txt"
    params:
        chains=config["chains"],
        parallel_chains=config["parallel_chains"],
        refresh=config["refresh"],
        max_treedepth=config["max_treedepth"],
        iter_warmup=config["iter_warmup"],
        iter_sampling=config["iter_sampling"]
    # singularity: "../singularity/rbayesian.sif"
    threads: 4
    resources:
        mem_mb=4000
    script:
        "../scripts/sample.R"
        