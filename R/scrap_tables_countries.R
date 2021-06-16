#get ids of countryes

#countries IDs
url <- "https://fbref.com/en/comps/676/UEFA-Euro-Stats"


  
  
  website <- read_html(url)

#scrap table of countries ------------------------------------------------------
tables <- website %>%
  html_table()
  
countries_raw <- tables[[8]]

#clean names ------------------------------------------------------------------
countries_clean <- countries_raw %>%
  select(Squad) %>%
  mutate(short = str_extract(Squad, "^\\S*"),
         country = str_remove_all(Squad,"^\\S*" ),
         country = str_trim(country),
         country = str_replace(country, " ", "-"))

#get ids ----------------------------------------------------------------------

links <- website %>%
  #all a elements
  html_elements("a") %>%
  html_attr("href") %>%
  tibble() %>%
  rename(raw = 1) %>%
  filter(str_detect(raw, "squads")) %>%
  mutate(country = str_extract(raw, "([^\\/]+$)"),
         country = str_remove(country, "-Stats"),
         country = str_trim(country),
         id_country = str_extract(raw, "(?<=squads\\/)(.*)(?=\\/)"))

#join ids with countries -------------------------------------------

setdiff(countries_clean$country, links$country)

countries <- countries_clean %>%
  left_join(links, by = "country") %>%
  distinct() %>%
  select(short, country, id_country)


#export
export(countries, file.path(dir_data, "all_countries.rds"))
  

  
  