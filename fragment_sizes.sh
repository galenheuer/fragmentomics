#!/bin/bash

#$ -j yes
#$ -l h_data=100G
#$ -l h_rt=5:00:00
#$ -l highp
#$ -o /u/project/zaitlenlab/galenheu/fragmentomics/sherin_data/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/fragmentomics/sherin_data/logfile.err

set -e  #exit on error

. /u/home/g/galenheu/mambaforge/etc/profile.d/conda.sh
conda activate jup

cohort="sherin_data"

bam="/u/project/zaitlenlab/galenheu/fragmentomics/${cohort}/filtered_50_500/"
output="/u/project/zaitlenlab/galenheu/fragmentomics/${cohort}/all_fragments/fragment_lengths.csv"
#extract="/u/project/zaitlenlab/galenheu/fragmentomics/extract_fragment_sizes.py"
extract="/u/project/zaitlenlab/galenheu/fragmentomics/extract_fl_efficient.py"

python ${extract} ${bam} ${output}
