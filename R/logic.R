df <- here("data", "qs.csv") %>% 
  read_csv()

# top-10 countries by median score with 5 or more universities in the ranking

df %>%
  group_by(country) %>%
  summarise(
    n = sum(!is.na(score)),
    median_score = median(score, na.rm = TRUE),
    mean_score = mean(score, na.rm = TRUE)) %>%
  filter(n >= 5) %>%
  arrange(desc(median_score))

# top-10 countries by median rank with 5 or more universities in the ranking

df %>%
  mutate(rank = row_number()) %>%
  group_by(country) %>%
  summarise(
    n = n_distinct(rank),
    median_rank = median(rank),
    mean_rank = mean(rank)) %>%
  filter(n >= 5) %>%
  arrange(median_rank)

# 5-country comparison ----------------------------------------------------

country_selection = c("Switzerland",
                      "France",
                      "United States",
                      "United Kingdom",
                      "Germany")

df %>% 
  filter(country %in% country_selection) %>%
  group_by(country) %>%
  summarise(n = sum(!is.na(score)),) %>%
  arrange(desc(n))

df %>% 
  filter(country %in% country_selection) %>%
  count(country, sort = TRUE)

# TODO: https://github.com/zambujo/unirankings/issues/2
# TODO: https://github.com/zambujo/unirankings/issues/7