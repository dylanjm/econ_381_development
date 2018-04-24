library(tidyverse)
library(rio)
library(rvest)
library(janitor)

# Rcode to go and fetch country codes
country_codes <- read_html("http://web.stanford.edu/~chadj/countrycodes6.3") %>% 
  html_text() %>% 
  str_extract_all("[A-Z]{3}") %>% 
  unlist() %>% 
  .[order(.)]

country_codes %>% 
  {tibble(codes = .)} %>% 
  write_csv(path = here::here("data/country_codes.csv"))

read_and_clean <- function(country_code = "USA"){
  dat_url <- paste0("http://www.stanford.edu/~chadj/snapshots/", country_code, ".xls")
  import(dat_url, skip = 9) %>% 
    clean_names() %>% 
    na.omit() %>% 
    filter(population != "NaN") %>% 
    mutate_all(as.numeric) %>% 
    mutate(country = country_code)
}

possibly_read_and_clean <- possibly(read_and_clean, otherwise = NULL)

final_clean_dat <- purrr::map(country_codes, ~ possibly_read_and_clean(.x)) %>% 
  compact() %>% 
  map_df(bind_rows)

write_csv(final_clean_dat, here::here("data/final_gdp_data.csv"))
