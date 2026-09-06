#!/bin/bash
set -euo pipefail

# =========================================
# CDE ETL Script — Extract, Transform, Load
# =========================================

RAW_DIR="raw"
TRANSFORMED_DIR="Transformed"
GOLD_DIR="Gold"
FILENAME="raw_data.csv"
OUTPUT_FILE="2023_year_finance.csv"

mkdir -p "$RAW_DIR" "$TRANSFORMED_DIR" "$GOLD_DIR"

# ---------- EXTRACT ----------
echo "=== EXTRACT ==="

if [ -z "${CSV_URL:-}" ]; then
	echo "❌ CSV_URL is not set. Run: export CSV_URL=\"your_link_here\""
	exit 1
fi

curl -sSL "$CSV_URL" -o "$RAW_DIR/$FILENAME"

if [ -f "$RAW_DIR/$FILENAME" ]; then
	echo "✅ File successfully saved to $RAW_DIR/$FILENAME"
else
	echo "❌ Download failed"
	exit 1
fi

# ---------- TRANSFORM ----------
echo "=== TRANSFORM ==="

awk -F',' '
NR==1 {
	for (i=1; i<=NF; i++) {
		h=$i
		gsub(/Variable_code/, "variable_code", h)
		header[i]=h
		if (h=="year") c1=i
		if (h=="Value") c2=i
		if (h=="Units") c3=i
		if (h=="variable_code") c4=i
	}
	print header[c1]","header[c2]","header[c3]","header[c4]
	next
}
{ print $c1","$c2","$c3","$c4 }
' "$RAW_DIR/$FILENAME" > "$TRANSFORMED_DIR/$OUTPUT_FILE"

if [ -s "$TRANSFORMED_DIR/$OUTPUT_FILE" ]; then
	echo "✅ Transformed file saved to $TRANSFORMED_DIR/$OUTPUT_FILE"
else
	echo "❌ Transform failed"
	exit 1
fi

# ---------- LOAD ----------
echo "=== LOAD ==="

cp "$TRANSFORMED_DIR/$OUTPUT_FILE" "$GOLD_DIR/"

if [ -f "$GOLD_DIR/$OUTPUT_FILE" ]; then
	echo "✅ File loaded into $GOLD_DIR/$OUTPUT_FILE"
else
	echo "❌ Load failed"
	exit 1
fi

echo "=== ETL COMPLETE ==="
