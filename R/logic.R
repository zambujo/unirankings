df <- here("data", "qs.csv") %>% 
  read_csv()

# m&m by country ----------------------------------------------------------

df %>%
  group_by(country) %>%
  summarise(
    count_score = sum(!is.na(score)),
    count_rank = n_distinct(rank),
    median_score = median(score, na.rm = TRUE),
    median_rank = median(rank),
    mean_score = mean(score, na.rm = TRUE),
    mean_rank = mean(rank)) %>%
  write_csv(path = here("data", "country_summary.csv"))
