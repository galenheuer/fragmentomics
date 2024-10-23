#!/bin/bash

#$ -cwd
#$ -j yes
#$ -l h_data=10G
#$ -l h_rt=1:00:00
#$ -t 1-40
#$ -l highp
#$ -o /u/project/zaitlenlab/galenheu/fragmentomics/sherin_data/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/fragmentomics/sherin_data/logfile.err

#filter bam files

set -e  #exit on error

. /u/home/g/galenheu/mambaforge/etc/profile.d/conda.sh
conda activate fragment

cohort="sherin_data"

#bam="/u/project/zaitlenlab/christac/panel/als_v1/mapped_bsbolt/redone/${SGE_TASK_ID}.umi_dedup.bam" #ucsf
#bam="/u/project/zaitlenlab/christac/panel/redone_fleur/mapped_bsbolt/redone/${SGE_TASK_ID}.umi_dedup.bam" #uq
bam="/u/project/zaitlenlab/galenheu/fragmentomics/${cohort}/bam/${SGE_TASK_ID}.bam"

filtered="/u/project/zaitlenlab/galenheu/fragmentomics/${cohort}/filtered_50_500/${SGE_TASK_ID}.filtered.bam"
output="/u/project/zaitlenlab/galenheu/fragmentomics/${cohort}/len_50_500/${SGE_TASK_ID}.tsv"

#filter by mapping quality = 20, insert size 50-500, primary alignment, properly paired
samtools view -h -f 0x2 ${bam} | awk -v MQ=20 -v MIN=50 -v MAX=500 'BEGIN {OFS="\t"} $1 ~ /^@/ || ($5 >= MQ && $9 >= MIN && $9 <= MAX && and($2, 0x100) == 0 && and($2, 0x800) == 0)' | samtools view -bS -o ${filtered}

samtools index -@ 4 ${filtered}

#output fragment size
bamPEFragmentSize -b ${filtered} --table ${output} --samplesLabel ${SGE_TASK_ID}

