#!/bin/bash
#SBATCH --time=96:00:00
#SBATCH -J growth
#SBATCH -o growth.%N.%j.out
#SBATCH -e growth.%N.%j.err
#SBATCH --mem=5G
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=ALL
####SBATCH -p unlimitq

# Environment
module purge
module load bioinfo/snakemake-5.25.0
module load system/singularity-3.7.3

# Variables
CONFIG=config/ressources.genologin.yaml
COMMAND="sbatch --cpus-per-task={cluster.cpus} --time={cluster.time} --mem={cluster.mem} -J {cluster.jobname} -o snake_subjob_log/{cluster.jobname}.%N.%j.out -e snake_subjob_log/{cluster.jobname}.%N.%j.err"
CORES=100
mkdir -p snake_subjob_log

# Workflow
snakemake -s Snakefile --use-singularity --singularity-args -j $CORES --cluster-config $CONFIG --cluster "$COMMAND" --keep-going
