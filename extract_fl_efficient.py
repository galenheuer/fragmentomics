import pysam
import pandas as pd
import os
import sys

def extract_fragment_sizes(bam_path):
    bamfile = pysam.AlignmentFile(bam_path, "rb")
    for read in bamfile:
        yield abs(read.template_length)  # Use a generator to avoid storing everything in memory
    bamfile.close()

def main(input_directory, output_csv):
    # Open the CSV file in write mode at the beginning
    with open(output_csv, 'w') as f:
        f.write("Sample,Fragment Size\n")  # Write the header

    # Traverse through each BAM file in the directory
    for filename in os.listdir(input_directory):
        if filename.endswith(".bam"):
            bam_path = os.path.join(input_directory, filename)
            sample_id = filename.split('.')[0]  # Extract 'i' from 'i.filtered.bam'
            print(f"Processing {sample_id}...")

            # Open the CSV file in append mode for each sample
            with open(output_csv, 'a') as f:
                for fragment_size in extract_fragment_sizes(bam_path):
                    f.write(f"{sample_id},{fragment_size}\n")  # Write each fragment size as you process it

    print(f"Fragment sizes saved to {output_csv}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python extract_fragments.py <input_directory> <output_csv>")
        sys.exit(1)

    input_directory = sys.argv[1]
    output_csv = sys.argv[2]

    main(input_directory, output_csv)

