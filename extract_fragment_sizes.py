import pysam
import pandas as pd
import os
import sys
import numpy as np

def extract_fragment_sizes(bam_path):
    bamfile = pysam.AlignmentFile(bam_path, "rb")
    fragment_sizes = []
    for read in bamfile:
        fragment_sizes.append(abs(read.template_length))
    bamfile.close()
    return fragment_sizes

def main(input_directory, output_csv):
    fragment_data = {}

    # Traverse through each BAM file in the directory
    for filename in os.listdir(input_directory):
        if filename.endswith(".bam"):
            bam_path = os.path.join(input_directory, filename)
            sample_id = filename.split('.')[0]  # Extract 'i' from 'i.filtered.bam'
            print(f"Processing {sample_id}...")
            fragment_sizes = extract_fragment_sizes(bam_path)
            #sample = np.random.choice(fragment_sizes, size=10000, replace=False)
            #fragment_data[sample_id] = sample
            fragment_data[sample_id] = fragment_sizes

    # Create a DataFrame for storing
    combined_data = []
    for filename, sizes in fragment_data.items():
        combined_data.extend([(filename, size) for size in sizes])
    
    df = pd.DataFrame(combined_data, columns=['Sample', 'Fragment Size'])

    # Save DataFrame to CSV
    df.to_csv(output_csv, index=False)
    print(f"Fragment sizes saved to {output_csv}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python extract_fragments.py <input_directory> <output_csv>")
        sys.exit(1)

    input_directory = sys.argv[1]
    output_csv = sys.argv[2]

    main(input_directory, output_csv)

