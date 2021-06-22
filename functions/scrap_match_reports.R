#'downloads all tables for the match for a given team
#'@param x url of the match
#'@param team team for which the data will be downloaded

scrap_match_reports <- function(x){
  
  message(x)
  #download passing
  
  passing <- download_passing_all(match_url = x, squad = team)
  
  possession <- download_possession_all(match_url = x, squad = team)
  
  full_report <- rbind(passing, possession)
  
  #add match
  full_report_clean <- full_report %>%
    mutate(match = str_extract(x, "([^\\/]+$)"),
           match = str_remove(match, "-UEFA-Euro"))
  
  return(full_report_clean)
  
  
}
