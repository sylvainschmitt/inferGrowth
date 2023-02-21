rule report_prep:
    input:
        filtered="results/data/filtered_trees.tsv",
        prepared="results/data/model_data.tsv"
    output:
        "results/report/report_prep.html"
    log:
        "results/logs/report_prep.log"
    benchmark:
        "results/benchmarks/report_prep.benchmark.txt"
    # singularity: "../singularity/rbayesian.sif"
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/report_prep.Rmd"
        