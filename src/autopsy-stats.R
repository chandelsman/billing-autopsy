# setup environment
library(here)
library(dplyr)
library(stringr)

# Import data
# autopsies completed during billing cycle
autopsies <- 
  readxl::read_excel(here("data", "2023.07.28-2023.08.27_autopsies.xls"))

# Stains completed
stains <- 
  list.files(
    path = here("data"),
    pattern = "^stain-data",
    full.names = TRUE
  ) %>% 
  sapply(readxl::read_excel, 
         simplify = FALSE,
  ) %>% 
  bind_rows()

# Select stains performed for autopsies (Result ID starts with "AU")
stain_count <- 
  stains %>% 
  filter(str_detect(`Result ID`, "^AU")) %>% 
  count(`Result ID`)

# Join autopsy and stain data
block_stain_counts <- 
  autopsies %>% 
  left_join(stain_count, by = "Result ID") %>% 
  rename(`Stain Count` = n)

# Output results to Excel
# Counts of blocks and stains performed on each autopsy
writexl::write_xlsx(block_stain_counts, here("output", "2023-08_autopsy-counts.xlsx"))

# Stains performed for each autopsy
stains %>% 
  filter(str_detect(`Result ID`, "^AU")) %>% select(`Result ID`, stain) %>% 
  writexl::write_xlsx((here("output", "2023-08_autopsy-stains.xlsx")))
  

