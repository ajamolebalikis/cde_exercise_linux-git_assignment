# CDE Exercise — ETL Pipeline

## Overview
This project implements a simple ETL (Extract, Transform, Load) pipeline as
part of the my task for Linux_Git_Assignment. I downloads a CSV file,
transforms it, loads it into a "Gold" folder, and includes a script to sort
CSV/JSON files. All work is version-controlled with Git.

## Folder Structure
- `raw/` — Contains the raw downloaded CSV file
- `Transformed/` — Contains the cleaned/transformed CSV file
- `Gold/` — Contains the final, loaded CSV file
- `json_and_csv/` — Contains CSV and JSON files moved by move_files.sh

## Requirements
- Bash shell (Git Bash on Windows)
- `curl` and `awk` (included by default in Git Bash)

## 1. ETL Script (`etl.sh`)

### What it does
- **Extract**: Downloads a CSV file from a URL (set via the `CSV_URL`
  environment variable) and saves it into the `raw/` folder. Confirms the
  download succeeded.
- **Transform**: Renames the `Variable_code` column to `variable_code`,
  selects only the `year`, `Value`, `Units`, and `variable_code` columns,
  and saves the result as `2023_year_finance.csv` in the `Transformed/`
  folder.
- **Load**: Copies the transformed file into the `Gold/` folder and confirms
  it was saved.

### How to run it
```bash
export CSV_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"
./etl.sh