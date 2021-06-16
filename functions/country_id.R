#'get country id

country_id <- function(pais,
                       ...){
  
  countries <- import(file.path(dir_data, "all_countries.rds"))
  
  id <-countries %>%
    filter(country == pais) %>%
    pull(id_country)
  
  
  return(id)
  
  
  
}



