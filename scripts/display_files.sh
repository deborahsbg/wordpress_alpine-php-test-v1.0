#!/bin/bash
# Script to display and save the contents of all files in the /docker directory and subdirectories

OUTPUT_FILE="all_file_contents.txt"
DIRECTORY="/docker"

# Ensure the output file is empty or doesn't exist
> "$OUTPUT_FILE"

echo "Displaying and saving all file contents in the $DIRECTORY directory and its subdirectories:"

# Iterate through all files in the specified directory and its subdirectories, excluding the output file
find "$DIRECTORY" -type f ! -name "$(basename "$OUTPUT_FILE")" | while read -r file; do
  echo -e "\n--- $file ---" | tee -a "$OUTPUT_FILE"
  cat "$file" >> "$OUTPUT_FILE" || echo "Error reading $file" | tee -a "$OUTPUT_FILE"
done

echo -e "\n--- End of file contents ---" | tee -a "$OUTPUT_FILE"

echo "All file contents have been saved to $OUTPUT_FILE"

