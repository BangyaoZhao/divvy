#!/bin/bash
#SBATCH --job-name=psbf
#SBATCH --time=4:00:00
#SBATCH --mail-user=xmding@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mem=50GB
#SBATCH --cpus-per-task=20

R CMD BATCH --no-save --no-restore prediction_nonP.R prediction_knn.Rout
