#'download table of possession
#'@param match_url An url of the game statistics
#'@param squad A string with the name of the country
#'@return A clean tibble of the possession table


download_passing <- function(match_url,
                                squad){
  
  #read website
  website <- read_html(match_url)
  #get the id of the squad
  id_squad <- country_id(squad)
  
  #define element
  element <- glue("#stats_{id_squad}_passing")
  
  #read table
  table_passing <- website %>%
    html_elements(element) %>%
    html_table() %>%
    .[[1]]
  
  #correct names of table
  names(table_passing) <- paste0(names(table_passing),"-",as.character(table_passing[1,]))
  
  
  print(names(table_passing))
  
  #clean names and format correctly
  passes <- table_passing %>%
    rename(Player = `-Player`,
           pass_attempted = `Total-Att`,
           pass_completed = `Total-Cmp`,
           pass_tot_distance = `Total-TotDist` ) %>%
    filter(!str_detect(Player,"Player")) %>%
    mutate(across(c(pass_attempted,pass_completed,pass_tot_distance), function(x){as.numeric(x)}))
  
  
   
  #import data of players
  players <-import(file.path(dir_data, "all_players.rds"))
  # 
  #fetch attributes from players into possetion
  stats <- passes %>%
    left_join(players, by = "Player") %>%
    select(Player, name, pass_attempted,pass_completed,pass_tot_distance, Age, Pos) %>%
    mutate(image = here("images", paste0(name, ".png")),
           name_label = str_remove(name, "[a-zA-Z]{2,}-"),
           avg_pass_distance  = round(pass_tot_distance/pass_attempted,1),
           avg_completed = round(pass_completed/pass_attempted, 1)
           ) %>%
    distinct()

  return(stats)
  
  
}
