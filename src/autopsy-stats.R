# setup environment
library(here)
library(tidyverse)

# Import data
autopsies <- 
  readxl::read_excel(here("data", "2022.09.28-2022.10.27_autopsies.xls"))
stains <- 
  list.files(
    path = here("data"),
    pattern = "^stain-data",
    full.names = TRUE
  ) %>% 
  sapply(read_excel, 
         simplify = FALSE,
  ) %>% 
  bind_rows()
  # readxl::read_excel(here("data", "2022.09.12-2022.10.27_stains.xls"))
  # readxl::read_excel(here("data", "stain-data-2022.10.27.xls"))

# Clean stain data
stain_count <- 
  stains %>% 
  filter(str_detect(`Result ID`, "^AU")) %>% 
  count(`Result ID`)

# Join autopsy and stain data
billing_data <- 
  autopsies %>% 
  left_join(stain_count, by = "Result ID") %>% 
  rename(`Stain Count` = n)

# Output results to Excel
writexl::write_xlsx(billing_data, here("output", "2022-10_autopsies.xlsx"))
