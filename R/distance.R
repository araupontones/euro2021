matches <- import(file.path(dir_data, "match_reports.xlsx"))
names(matches)
matches2 <- matches %>%
  select(Player, match)

distance <- matches %>%
  select(Player, country,distance = `poss-Carries-TotDist`) %>%
  filter(!str_detect(Player, "Players")) %>%
  mutate(distance = as.numeric(distance)) %>%
  group_by(Player, country) %>%
  summarise(distance = sum(distance),
            matches = n(),
            avg_distance = distance /matches,
            .groups = 'drop') %>%
  arrange(desc(distance))%>%
  top_n(10)
  
View(distance)
  
top_n(distance)


export(distance, file.path(dir_data_charts, "distance.csv"))
View(matches)
