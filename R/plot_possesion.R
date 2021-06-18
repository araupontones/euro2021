
load_functions(dir_style)



#define paramenters
match_url <- "https://fbref.com/en/matches/107fd412/Spain-Sweden-June-14-2021-UEFA-Euro"
png_name <- "SpainvsSweden_pss.png"
squad <- "Spain" #Squad to download data from
match <- "Spain VS Sweden"


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
