#!/bin/bash
#SBATCH --job-name=psbf
#SBATCH --time=60:00:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mem=1000
#SBATCH --cpus-per-task=1

R CMD BATCH clinicalmodel.R
