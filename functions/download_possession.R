#'download table of possession
#'@param match_url An url of the game statistics
#'@param squad A string with the name of the country
#'@return A clean tibble of the possession table


download_possession <- function(match_url,
                             squad){
  
  #read website
  website <- read_html(match_url)
  #get the id of the squad
  id_squad <- country_id(squad)
  
  #define element
  element <- glue("#div_stats_{id_squad}_possession")
  
  #read table
  table_possession <- website %>%
    html_elements(element) %>%
    html_table() %>%
    .[[1]]
  
  #correct names of table
  names(table_possession) <- paste0(names(table_possession),"-",as.character(table_possession[1,]))
  
  
  print(names(table_possession))
  
  #clean names and format correctly
  possesion <- table_possession %>%
    rename(Player = `-Player`,
           Touches = `Touches-Touches`) %>%
    filter(!str_detect(Player,"Player")) %>%
    mutate(Touches = as.numeric(Touches))
  
  
  #import data of players
  players <-import(file.path(dir_data, "all_players.rds"))
  
  #fetch attributes from players into possetion
  stats <- possesion %>%
    left_join(players, by = "Player") %>%
    select(Player, Touches, name) %>%
    mutate(image = here("images", paste0(name, ".png")),
           name_label = str_remove(name, "[a-zA-Z]{2,}-"),
           perc_touches = Touches / sum(Touches))
  
  return(stats)
  
  
}
