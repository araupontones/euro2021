#create tibble with url of the squads


url_squads <- tibble(
  
  country= c("France", 
            "Germany",
            "Spain"
             ),
  url = c("https://fbref.com/en/squads/b1b36dcd/France-Stats",
         "https://fbref.com/en/squads/c1e40422/Germany-Stats",
         "https://fbref.com/en/squads/b561dd30/Spain-Stats"
         )
)


export(url_squads, file.path(dir_data, "url_squads.rds"))
