rule prep_mdata:
    input:
        "results/data/filtered_trees.tsv"
    output:
        "results/data/model_data.tsv"
    log:
        "results/logs/prep_mdata.log"
    benchmark:
        "results/benchmarks/prep_mdata.benchmark.txt"
    singularity: 
        "https://github.com/sylvainschmitt/singularity-r-bioinfo/releases/download/0.0.3/sylvainschmitt-singularity-r-bioinfo.latest.sif"
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/prep_mdata.R"
        