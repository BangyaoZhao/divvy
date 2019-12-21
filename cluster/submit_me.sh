#!/bin/bash
#SBATCH --job-name=psbf
#SBATCH --time=60:00:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mem=50GB
#SBATCH --cpus-per-task=20

R CMD BATCH rf.R
R CMD BATCH gp.R
R CMD BATCH knn.R
R CMD BATCH rpart.R
R CMD BATCH treebag.R
R CMD BATCH svmRadial.R
