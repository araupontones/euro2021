library(httr)





players <- import(file.path(dir_data, "all_players.rds")) %>%
  filter(country == "Spain")

save_png <- function(i){
  
  db <- players %>% filter(id == i)
  
  url<- unique(db$img)
  id <- unique(db$id)
  name <- unique(db$name)
  
  message(name)
  
  print(class(url))

  r <- GET(url)
  
  Sys.sleep(2)
  exdir <- file.path("images")

  exfile <- file.path(exdir, glue("{name}.png"))

  filecon <- file(exfile, "wb")
  #write data contents to download file
  writeBin(r$content, filecon)
  #close the connection
  close(filecon)

  
  
}

ids <- unique(players$id)

for(i in ids){
  message(i)
  
  save_png(i)
}
