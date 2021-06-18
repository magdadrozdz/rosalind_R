#!/bin/bash 

#$ -N RScript_IO
#$ -P ludwig.prjc
#$ -q short.qc
#$ -cwd
#$ -j y
#$ -o /well/ludwig/users/utu046/mix_deco/logs

PATH=/apps/eb/${MODULE_CPU_TYPE}/software/R/3.6.2-foss-2019b/bin:/apps/well/bedtools/2.27.0/bin:$PATH

RSCRIPT=$1

module load R/3.6.2-foss-2019b

cd /well/ludwig/users/utu046/mix_deco

Rscript ${RSCRIPT} 

