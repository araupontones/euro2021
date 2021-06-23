#'Returns a Tibble with the report table of the given dimension
#'@param url_match Url of the match to scrap
#'@param dimension Dimention of the table to be scraped 
#'@param squad team of interest

scrap_single_table <- function(url_match, 
                               dimension = c("passes", "possesion", "summary",
                                             "pass_types", "defense", "misc"),
                               team,
                               ...
                               ){
  message(glue("from scrap_single_table {team}"))
  #get the id of the squad
  id_squad <- country_id(team)
  
  
  if(dimension=="passes"){
    
    #define element
    element <- glue("#stats_{id_squad}_passing")
    prefix <- "pass"
    
  }else if(dimension == "possesion"){
    
    element <- glue("#div_stats_{id_squad}_possession")
    prefix <- "poss"
    
  } else if(dimension == "summary"){
    
    
    element <- glue("#stats_{id_squad}_summary")
    prefix <- "sum"
    
  }else if(dimension == "pass_types"){
    
    
    element <- glue("#stats_{id_squad}_passing_types")
    prefix <- "passtype"
    
  }else if(dimension == "defense"){
    
    
    element <- glue("#stats_{id_squad}_defense")
    prefix <- "def"
  }else if(dimension == "misc"){
    
    
    element <- glue("#stats_{id_squad}_misc")
    prefix <- "misc"
  }
  
  
  #read website
  website <- read_html(url_match)
  
  message(element)
  
  #read table
  table_raw <- website %>%
    html_elements(element) %>%
    html_table() %>%
    .[[1]]
  
  #clean names of variables (except for player, #, pos, Age)
  old_names <- names(table_raw)
  names(table_raw) <- as.character(table_raw[1,])
  names(table_raw)[-c(1:4)] <- paste(prefix, old_names[-c(1:4)],names(table_raw)[-c(1:4)], sep = "-")
  
  #drop first column that included the col names
  table_clean <- table_raw[-1,]
  
  #print(names(table_clean))
  
  #make longer
  passing_long <- table_clean %>%
    pivot_longer(-c(Player, `#`, Pos, Age),
                 names_to = "indicator",
                 values_to = "value") 
  
 
  return(passing_long)
  
  
  
  
  
  
}
