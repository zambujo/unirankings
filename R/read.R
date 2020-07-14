"https://www.topuniversities.com/sites/default/files/qs-rankings-data/946820.txt" %>% 
  fromJSON(flatten = TRUE) %>%
  as.data.frame() %>%
  as_tibble() %>%
  clean_names() %>%
  rename_all(str_remove, pattern = "data_") %>%
  write_csv(path = here("data", "qs.csv"))
