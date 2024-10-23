#!/bin/bash

#$ -cwd
#$ -j yes
#$ -l h_data=5G
#$ -l h_rt=1:00:00
#$ -l highp
#$ -o /u/project/zaitlenlab/galenheu/fragmentomics/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/fragmentomics/logfile.err

set -e

. /u/home/g/galenheu/mambaforge/etc/profile.d/conda.sh
conda activate base

cohort="uq"

input_dir="/u/project/zaitlenlab/galenheu/fragmentomics/${cohort}/counts"
output_dir="/u/project/zaitlenlab/galenheu/fragmentomics/${cohort}"

# Output file
output="${output_dir}/${cohort}_counts.csv"

# Initialize a variable to track if the header has been written
header_written=false

# Loop through all files in the directory
for file in ${input_dir}/*; do
    if [ "$header_written" = false ]; then
        # Write the header (first line) from the first file to the output file
        head -n 1 "$file" > "$output"
        header_written=true
    fi

    # Append the contents of each file, excluding the header, to the output file
    tail -n +2 "$file" >> "$output"
done

echo "All files have been combined into $output."

