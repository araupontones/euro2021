#Scraps the passing stats

#'@param match_url An url of the game statistics
#'@param squad A string with the name of the country
#'@return A clean tibble of the possession table


download_passing_all <- function(match_url,
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
  
  #clean names of variables (except for player, #, pos, Age)
  names(table_passing) <- as.character(table_passing[1,])
  names(table_passing)[-c(1:4)] <- paste("pass", names(table_passing)[-c(1:4)], sep = "-")
  
  #drop first column that included the col names
  table_passing <- table_passing[-1,]
  
  print(names(table_passing))
  
  #make longer
  passing_long <- table_passing %>%
    pivot_longer(-c(Player, `#`, Pos, Age),
                 names_to = "indicator",
                 values_to = "value") 
  
  return(passing_long)
  
}
