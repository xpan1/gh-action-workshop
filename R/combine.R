# For the second job in matrix.yaml
library(readr)
library(fs)
library(dplyr)
#read in all CSV files in the output directory and arrange by R^2 value
model_report <- read_csv(fs::dir_ls("output")) |>
  arrange(desc(r.squared))

# write data frame out to a CSV file
write_csv(model_report, "output/model_report.csv")
