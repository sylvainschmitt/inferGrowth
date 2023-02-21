rule extract_pars:
    input:
        expand("results/model/chain-{chain}.tsv", chain=range(1,config["chains"]+1))
    output:
        "results/model/chains.tsv"
    log:
        "results/logs/extract_pars.log"
    benchmark:
        "results/benchmarks/extract_pars.benchmark.txt"
    params:
        pars=config["pars"]
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/extract_pars.R"
        