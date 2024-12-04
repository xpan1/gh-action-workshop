library(pointblank)
library(readr)
library(tidyr)
library(dplyr)

heliconia <- read_csv("data/heliconia_sample.csv")


heliconia_tidy <- heliconia |> 
  select(-starts_with("notes_")) |> 
  pivot_longer(
    cols = c(-ranch, -plot, -tag_number, -row, -column),
    names_sep = "_",
    names_to = c("variable", "year")
  ) |> 
  pivot_wider(names_from = "variable", values_from = "value")

al <- action_levels(
  stop_at = 1 #error if even 1 row fails
)

heliconia_tidy |> 
  col_vals_between(
    columns = shoots,
    left = 1,
    right = 20,
    na_pass = TRUE,
    actions = al
  ) |> 
  col_vals_between(
    columns = height,
    left = 0,
    right = 200,
    na_pass = TRUE,
    actions = al
  ) |> 
  col_vals_between(
    columns = infl,
    left = 0,
    right = 6,
    na_pass = TRUE,
    actions = al
  )
