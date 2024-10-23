import pandas as pd
import sys
import os

def process_sample_csv(input_csv, output_csv):
    # Extract the sample number from the input CSV filename
    sample_number = os.path.splitext(os.path.basename(input_csv))[0]  # Removes .csv from the filename

    # Load the fragment sizes for a sample
    df = pd.read_csv(input_csv)

    # Ensure the fragment sizes are within the 50-500 bp range
    fragment_counts = df['Fragment Size'].value_counts()

    # Initialize a dictionary to store counts for each fragment length between 50 and 500 bp
    length_counts = {i: 0 for i in range(50, 501)}

    # Update the dictionary with actual counts from the sample
    for length, count in fragment_counts.items():
        if 50 <= length <= 500:
            length_counts[length] = count

    # Convert the dictionary to a DataFrame
    length_counts_df = pd.DataFrame(list(length_counts.items()), columns=['Fragment Size', 'Count'])

    # Transpose the DataFrame to make it a single row
    length_counts_t = length_counts_df.set_index('Fragment Size').transpose()

    # Add the sample number as the first column
    length_counts_t.insert(0, 'Sample', sample_number)

    # Save the transposed DataFrame to a new CSV file
    length_counts_t.to_csv(output_csv, index=False)
    print(f"Fragment length counts saved to {output_csv} as a single row with sample number")

if __name__ == "__main__":
    # Check if correct number of arguments are passed
    if len(sys.argv) != 3:
        print("Usage: python script.py <input_csv> <output_csv>")
        sys.exit(1)

    # Input and output CSV files from command-line arguments
    input_csv = sys.argv[1]
    output_csv = sys.argv[2]

    # Process the input CSV and save the result to the output CSV
    process_sample_csv(input_csv, output_csv)
