#Scraps the passing stats

#'@param match_url An url of the game statistics
#'@param squad A string with the name of the country
#'@return A clean tibble of the possession table


download_possession_all <- function(match_url,
                             squad){
  
  #read website
  website <- read_html(match_url)
  #get the id of the squad
  id_squad <- country_id(squad)
  
  #define element
  element <- glue("#div_stats_{id_squad}_possession")
  

  
  #read table
  table_possesion <- website %>%
    html_elements(element) %>%
    html_table() %>%
    .[[1]]
  
  #clean names of variables (except for player, #, pos, Age)
  names(table_possesion) <- as.character(table_possesion[1,])
  names(table_possesion)[-c(1:4)] <- paste("posse", names(table_possesion)[-c(1:4)], sep = "-")
  
  #drop first column that included the col names
  table_possesion <- table_possesion[-1,]
  
  print(names(table_possesion))
  
  #make longer
  possesion_long <- table_possesion %>%
    pivot_longer(-c(Player, `#`, Pos, Age),
                 names_to = "indicator",
                 values_to = "value") 
  
  return(possesion_long)
  
}
