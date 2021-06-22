#define paths

options(defaultPackages=c(getOption("defaultPackages"),
                          "cowplot","extrafont",
                          "glue","ggplot2","ggtext","ggimage", "ggrepel", "ggflags",
                          "httr","here","janitor",
                           "rio","rio","rvest",
                          "stringr",
                          "dplyr", "tidyr" ))



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

message("Euro 2021!")


