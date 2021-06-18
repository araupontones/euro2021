#'get unique id of players, and their link to their img

#'@param url A url in fbref where the table with the player info sits
#'@param country A string: name of the country
#'@retutn A tibble with the name of the player and the url to its img

tibble_players <- function(pais,
                           ...) {
  
  
  
  #get url of squad ---------------------------------------------------------
  tible_squads <- import(file.path(dir_data, "url_squads.rds"))
  
  
  
  url <- tible_squads %>%
    filter(country == pais) %>%
    pull(url)
  
  print(url)
  
  website <- read_html(url)
  
#scrap table of players ------------------------------------------------------
  tables <- website %>%
    html_table()
  
  players_raw <- tables[[1]]
  
  
  
#get url of players-----------------------------------------------------------
  links <- website %>%
    #all a elements
    html_elements("a") %>%
    html_attr("href") %>%
    #to differenciate with non relevant links
    .[str_detect(.,"players")] %>%
    unique() %>%
    tibble::tibble() %>%
    rename(raw = 1) %>%
    #filter out unrelevat urls
    filter(!str_detect(raw, "summary|matchlogs")) %>%
    #extract relevant information from the url
    mutate(name = str_extract(raw, "([^\\/]+$)"),
           id = str_extract(raw, "(?<=players\\/)(.*)(?=\\/)"),
           img = glue("https://fbref.com/req/202005121/images/headshots/{id}_2018.jpg")) %>%
    filter(!is.na(name))
  
  #clean players ----------------------------------------------------------------
  names(players_raw) <- as.character(players_raw[1,])
  
  #print(players_raw)
 
  
  players_clean <- players_raw %>%
    select(Player, Pos, Age) %>%
    filter(!Player %in% c("Player", "Squad Total", "Opponent Total")) %>%
    mutate(name = str_replace_all(Player, " ", "-"),
           name = stringi::stri_trans_general(name, "Latin-ASCII"),
           name = str_replace_all(name, "'", ""),
           country = country,
           Age = str_replace(Age, "-", "."),
           Age = as.numeric(Age),
           #because some players come with two Pos
           Pos = str_extract(Pos, "[A-Z]{2,}")
                           ) %>%
    left_join(links, by="name")


 

  return(players_clean)
  
  
  
  
}
