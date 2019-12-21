#!/bin/bash
#SBATCH --job-name=psbf
#SBATCH --time=4:00:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mem=50GB
#SBATCH --cpus-per-task=100
#SBATCH --array=1-6

R CMD BATCH --no-save --no-restore allinone.R allinone$SLURM_ARRAY_TASK_ID.Rout
