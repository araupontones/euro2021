#define paths

dir_data <- "data"
dir_data_players <- file.path(dir_data, "players")
dir_functions <- "functions"
dir_style <- "styles"

#load libraries



load_functions <- function(dir){
  
  functions<- list.files(dir, pattern = ".R", full.names = T)
  
  for(x in functions){
    
    source(x, encoding = 'utf-8')
    
    
  }
}

load_functions(dir_functions)
load_functions(dir_style)


message("Euro 2021!")
