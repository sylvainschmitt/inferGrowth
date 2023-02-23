rule filter_trees:
    input:
        expand("data/{inventory}", inventory=config["inventory"])
    output:
        "results/data/filtered_trees.tsv"
    log:
        "results/logs/filter_trees.log"
    benchmark:
        "results/benchmarks/filter_trees.benchmark.txt"
    singularity: 
        "https://github.com/sylvainschmitt/singularity-r-bioinfo/releases/download/0.0.3/sylvainschmitt-singularity-r-bioinfo.latest.sif"
    params:
        n_census=config["n_census"],
        n_ind_species=config["n_ind_species"],
        n_years=config["n_years"],
        filter_data=config["filter_data"],
        n_sp_max=config["n_sp_max"],
        n_ind_sp_max=config["n_ind_sp_max"]
    threads: 1
    resources:
        mem_mb=1000
    script:
        "../scripts/filter_trees.R"