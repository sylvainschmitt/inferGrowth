rule prep_mdata:
    input:
        "results/data/filtered_trees.tsv"
    output:
        "results/data/model_data.tsv"
    log:
        "results/logs/prep_mdata.log"
    benchmark:
        "results/benchmarks/prep_mdata.benchmark.txt"
    # singularity: "../singularity/rbayesian.sif"
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/prep_mdata.R"
        