#'downloads all tables for the match for a given team
#'@param x url of the match
#'@param team team for which the data will be downloaded

scrap_match_reports <- function(x, team){
  
  message(glue("From scrap_match_reports {team} {x}"))
  date <- str_extract(x, "(June|July)-[0-9]{1,}-2021")
  message(date)
  
  match_to_check <- paste(team,date, sep = "-")
  
  #check if the match exists
  saved_matches <- import(file.path(dir_data, "match_reports.rds"))
  
  matches_in_local <- saved_matches %>%
    group_by(country, date) %>%
    select(country, date) %>%
    slice(1) %>%
    ungroup()%>%
    mutate(check = paste(country,date, sep = "-")) %>%
    .$check
  
  
  return_table <- function(y){ 
    
    t <- scrap_single_table(url_match = x, dimension = y, team = team)
    return(t)
  }
  
  if(!match_to_check %in% matches_in_local){
  
    message("downloading!")
    
  
  
  #define dimensions
  dimensions<-c("passes", "possesion",
                "pass_types", "defense", "misc")
  
  list_of_tables <- purrr::map(dimensions,return_table)
  
  full_report <- do.call(rbind, list_of_tables)
  
  
  
  
  #full_report <- rbind(passing, possession)
  match <- str_extract(x, "([^\\/]+$)")
  match <- str_remove(match, "-UEFA-Euro")
  
  #add match
  full_report_clean <- full_report %>%
  mutate(match = match)
  
  message(match)
  
  return(full_report_clean)
  
  } else{
    
    message("Data exists in downloads")
  }
  
 
  
  
}
