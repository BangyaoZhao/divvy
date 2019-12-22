#!/bin/bash
#SBATCH --job-name=psbf
#SBATCH --time=15:00:00
#SBATCH --mail-user=xmding@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mem=50GB
#SBATCH --cpus-per-task=20
#SBATCH --array=2,3

R CMD BATCH --no-save --no-restore prediction_nonP.R prediction$SLURM_ARRAY_TASK_ID.Rout