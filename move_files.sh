#!/bin/bash
set -euo pipefail

# =========================================
# Move CSV and JSON files into json_and_csv/
# Usage: ./move_files.sh <source_folder>
# =========================================

SOURCE_DIR="$1"
DEST_DIR="json_and_csv"

mkdir -p "$DEST_DIR"

echo "=== Moving CSV and JSON files from $SOURCE_DIR ==="

shopt -s nullglob

for f in "$SOURCE_DIR"/*.csv "$SOURCE_DIR"/*.json; do
    mv "$f" "$DEST_DIR/"
    echo "Moved: $f -> $DEST_DIR/"
done

echo "Done."
