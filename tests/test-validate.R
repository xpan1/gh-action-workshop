library(pointblank)
library(readr)
library(tidyr)
library(dplyr)
library(here)

heliconia <- read_csv(here("data/heliconia_sample.csv"))

heliconia_tidy <- heliconia |> 
  select(-starts_with("notes_")) |> 
  pivot_longer(
    cols = c(-ranch, -plot, -tag_number, -row, -column),
    names_sep = "_",
    names_to = c("variable", "year")
  ) |> 
  pivot_wider(names_from = "variable", values_from = "value")

test_that("Data makes sense", {
  expect_col_vals_between(
    heliconia_tidy,
    columns = shoots,
    left = 1,
    right = 20,
    na_pass = TRUE
  )
  expect_col_vals_between(
    heliconia_tidy,
    columns = height,
    left = 0,
    right = 200,
    na_pass = TRUE
  )  
  col_vals_between(
    heliconia_tidy,
    columns = infl,
    left = 0,
    right = 6,
    na_pass = TRUE
  )
})
