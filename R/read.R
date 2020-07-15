"https://www.topuniversities.com/sites/default/files/qs-rankings-data/946820.txt" %>% 
  fromJSON(flatten = TRUE) %>%
  as.data.frame() %>%
  as_tibble() %>%
  clean_names() %>%
  rename_all(str_remove, pattern = "data_") %>%
  mutate(rank = row_number()) %>%
  rename(country_name = country) %>%
  mutate(country = countrycode(country_name, 'country.name', 'iso2c')) %>%
  write_csv(path = here("data", "qs.csv"))
