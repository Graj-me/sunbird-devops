#!/bin/bash

# Script to create mappings for all indices
# Usage: ./create_mappings.sh

echo "# Elasticsearch Mapping Creation Commands"
echo "# Generated for ES 7.17.13 compatibility"
echo ""

# Function to get index name from filename
get_index_name() {
    local filename=$1
    # Remove -mapping.json suffix and get the base name
    echo "${filename%-mapping.json}"
}

# Process each mapping file
for mapping_file in *.json; do
    if [ -f "$mapping_file" ]; then
        index_name=$(get_index_name "$mapping_file")
        echo "# Creating mapping for index: $index_name"
        echo "curl --location --request PUT 'localhost:9200/$index_name/_mapping/' \\"
        echo "--header 'Content-Type: application/json' \\"
        echo "--data @$mapping_file"
        echo ""
    fi
done

echo "# Note: Make sure the indices exist before applying mappings"
echo "# If indices don't exist, create them first with basic settings" 