#' Dwnload and append possession and passess tables
#' @param squad name of the country to download the data from


download_passes_possession <-function(squad){
  pas= download_passing(match_url = match_url,
                        squad = squad) %>%
    mutate(squad = squad) %>%
    #drop repeated vars
    select(-c(image, name))
  
  message(names(pas))
  
  pos = download_possession(match_url = match_url,
                            squad = squad) 
  
  app <- left_join(pos, pas, by = "Player")
  
  return(app)
  
  
  
}
