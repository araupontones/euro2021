#'downloads all the match reports of Euro 2021
#'@param team country to download the data from
#'@result A list with the reports

download_report <- function(team = country){
  
  this_country <- filter(squads, country == team)
  
  #fetch url and id of country
  url <- this_country$url
  id <- this_country$id_country
  
  # message(team)
  # message(url)
  # message(id)
  
  #read the site of the squad
  squad_site <- read_html(url)
  
  #Table containing the matches that this team has played
  links_euro <-squad_site %>%
    html_elements('#matchlogs_for') %>%
    html_elements("a")
  
  #convert to tibble
  squad_df <- tibble(
    text = links_euro %>% html_text(),
    href = links_euro %>% html_attr("href")
  ) %>%
    #keep only reports from the Euro
    filter(str_detect(text, "Report"),
           str_detect(href, "UEFA-Euro")) %>%
    mutate(url_match = glue("https://fbref.com{href}"),
           date = str_extract(url_match, "(June|July)-[0-9]{1,}-2021"),
           country = team)
  
  #all the matches of the squad
  matches_url <- squad_df$url_match
  
  print(matches_url)
  
  #download all the data of the squad
  tables_list <- purrr::map(matches_url, scrap_match_reports, team = team)
  
  
  #append tables of all the matches of the squad
  squad_stats <- do.call(rbind, tables_list)
  
  print(length(squad_stats))
  if(length(squad_stats)>0){
    
    message("?")
    
    #clean table
    squad_clean <- squad_stats %>%
      mutate(country = team,
             #clean team the squad played against
             date = str_extract(match, "(June|July)-[0-9]{1,}-2021"),
             match = str_remove_all(match, "-(June|July)-[0-9]{1,}-2021"),
             against = str_remove(match, team),
             against = str_remove(against, "-(June|July)-[0-9]{1,}-2021"),
             against = str_remove(against, "-")
      )
    
    
    
    #make it wide
    report_wide <- squad_clean %>%
      pivot_wider(id_cols = -c(value, indicator),
                  values_from = value,
                  names_from = indicator)
    
    
    
    return(report_wide)
  }
}