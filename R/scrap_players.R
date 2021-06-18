#get information of players

countries <- import(file.path(dir_data, "all_countries.rds")) 
countries <- unique(countries$country)


countries
#scrap table with information of players

for(c in countries){


country <- c
message(country)

players_df <- tibble_players(pais = country) #defined in functions (add the url to R/tibble_url_squads)



if(sum(is.na(players_df$img)) >0){
  
  message("A player is missing url")
  
}

export(players_df, file.path(dir_data_players, glue("{country}.rds")))

}





#append with saved squads and export -----------------------------------------
saved_squads <- list.files(dir_data_players, pattern = ".rds", full.names = T)

append <- function(x){
  
  df <- import(x)
  
  return(df)
}



all_squads <-lapply(saved_squads, append)
squads_euro <- do.call(rbind, all_squads)
export(squads_euro,file.path(dir_data, "all_players.rds"))

