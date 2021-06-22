
squads <- import(file.path(dir_data, "url_squads.rds"))



#this is the vector that will run the loop on
squads$url

#this will be the elements of the function
squad <- squads[1,]
url <- squad$url
id <- squad$id_country
team <- squad$country

#dor each squad:
#read the site of the squad
squad_site <- read_html(url)

#Table containing the mactches
links_euro <-squad_site %>%
  html_elements('#matchlogs_for') %>%
  html_elements("a")

#convert to tibble
squad_df <- tibble(
text = links_euro %>% html_text(),
href = links_euro %>% html_attr("href")
) %>%
  #keep only reports from the Euro
  filter(str_detect(text, "Report"),
         str_detect(href, "UEFA-Euro")) %>%
  mutate(url_match = glue("https://fbref.com{href}"))


#all the matches of the squad
matches_url <- squad_df$url_match

#download all the data of the squad
tables_list <- purrr::map(matches_url,scrap_match_reports)

#append tables of all the matches of the squad
squad_stats <- do.call(rbind, tables_list)

#clean table
squad_clean <- squad_stats %>%
  mutate(country = team,
         #clean team the squad played against
         against = str_remove(match, team),
         against = str_remove(against, "June|July"),
         against = str_remove(against, "--[0-9]{1,}-2021"),
         against = str_remove(against, "-")
  )
         
#download passing

names(squad_clean)

report_wide <- squad_clean %>%
  pivot_wider(id_cols = c(Player, `#`, Pos, Age, country),
               values_from = value,
                names_from = indicator)
