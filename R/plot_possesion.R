library(janitor)
library(ggplot2)
library(ggtext)
library(ggimage)
library(here)
library(rvest)
library(stringr)
library(glue)
library(rio)
library(dplyr)



#define paramenters
match_url <- "https://fbref.com/en/matches/95d34c87/France-Germany-June-15-2021-UEFA-Euro"
png_name <- "France_vs_germany.png"
squad <- "France" #Squad to download data from

max(stats$perc_touches)

#download data of possession (function in functions)
stats <-download_possession(match_url = match_url,
                             squad = squad)


#plot touches (in functions)
plot_touches(db = stats,
             juego = "France VS Germany",
             sub_titulo = "37% of all Spain's ball touches passed through Jordi Alba, Torres and Koke",
             fecha = "June 15th, 2021",
             color_squad = blue_france,
             nudge_image = 90,
             nudge_player = 150 )



#export
exfile <- file.path("charts", png_name)

ggsave(exfile, last_plot(),
       dpi = 320,
       width = 13,
       height = 13)
