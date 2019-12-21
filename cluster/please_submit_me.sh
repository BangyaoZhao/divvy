#!/bin/bash
#SBATCH --job-name=psbf
#SBATCH --time=60:00:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mem=20GB
#SBATCH --cpus-per-task=20
#SBATCH --array=1-6

R CMD BATCH --no-save --no-restore allinone.R allinone$SLURM_ARRAY_TASK_ID.Rout
