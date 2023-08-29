# Autopsy Billing

Generate list of autopsies that need to be invoiced. The scripts in this project generate a list of autopsies that need to be billed. The list is provided to Jaimi for validation and invoicing. This is a stop-gap effort while we transition from the manual method previously used for autopsy billing and into the current tech-billing process.

## Data

Data is gathered from a dynamic report in LigoLab using completed date and Result ID prefix (AU).

- Reporting > Dynamic Reports > Billing Report Autopsy

### Base tab

- Completed = 28th of previous month throuh 27th of current month

### Extended tab

- Result ID Prefix = Autopsy (tech only)

### Export Data

- Save output as excel (YYYY.MM.DD-YYYY.MM.DD_autopsies.xls) in the project data folder.

## Ouput

- Adjust the dates in the autopsy-stats.R script
- Run the script to write the data to an Excel file in the output folder
- Send the output/YYYY-MM_autopsy-counts and output/YYYY-MM_autopsy-stains to Jaimi Sweet