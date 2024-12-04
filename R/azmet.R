#' this is a contrived example and you wouldn't actually want to use GitHub
#' actions to run this because it isn't computationaly expensive at all.  For
#' more realistic examples of using GitHub actions for parallel computations
#' see:
#' https://github.com/Aariq/forestTIME-builder/blob/actions-matrix/.github/workflows/create_db.yml
#' for an R example or:
#' https://github.com/uwescience/GitHubActionsTutorial-USRSE24/blob/main/.github/workflows/batch_image_correlation.yml
#' for a python example.
library(azmetr) #https://github.com/uace-azmet/azmetr
library(lubridate)
library(broom)
# station_info$meta_station_id |> stringr::str_c(collapse = ", ") 

#reads station ID from an environment variable set by the action in matrix.yaml
station_id <- Sys.getenv("AZMET_STATION", unset = "az01") 

#retrieve daily data for that station
daily <- az_daily(station_id = station_id, start_date = "2021-01-01", end_date = today()-1)

#some silly linear model to predict battery voltage based on time, precipitation, and temperature
m <- lm(meta_bat_volt_max ~ datetime * precip_total_mm * temp_air_maxC, data = daily)

#save model summary
fs::dir_create("output")
glance(m) |>
  tibble::add_column(station_id = station_id, .before = "r.squared") |> 
  readr::write_csv(paste0("output/", station_id, "_model_summary.csv"))

