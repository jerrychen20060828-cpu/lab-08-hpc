#!/bin/bash

set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 BUCKET BOOK_DIR" >&2
    exit 1
fi

bucket=$1
book_dir=$2

mkdir -p "$book_dir"
book_dir=$(realpath "$book_dir")

aws s3 cp "s3://$bucket/" "$book_dir/" \
    --recursive \
    --exclude "*" \
    --include "*.txt"

echo "File path" > book_list.txt
find "$book_dir" -maxdepth 1 -type f -name "*.txt" -print | sort >> book_list.txt

book_count=$(($(wc -l < book_list.txt) - 1))
echo "Wrote $book_count book files to book_list.txt"
