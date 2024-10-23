#!/bin/bash

#$ -cwd
#$ -j yes
#$ -t 97-192
#$ -l h_data=15G
#$ -l h_rt=1:00:00
#$ -l highp
#$ -o /u/project/zaitlenlab/galenheu/fragmentomics/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/fragmentomics/logfile.err

set -e

. /u/home/g/galenheu/mambaforge/etc/profile.d/conda.sh
conda activate jup

cohort="uq"

i=${SGE_TASK_ID}
input="/u/project/zaitlenlab/galenheu/fragmentomics/${cohort}/all_fragments/${i}.csv"
output="/u/project/zaitlenlab/galenheu/fragmentomics/${cohort}/counts/${i}.csv"
extract="/u/project/zaitlenlab/galenheu/fragmentomics/get_fragment_counts.py"

python ${extract} ${input} ${output}
