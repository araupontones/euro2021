#plot distance

load_functions(dir_style)






#define paramenters
match_url <- "https://fbref.com/en/matches/107fd412/Spain-Sweden-June-14-2021-UEFA-Euro"
png_name <- "Spain_vs_Sweden_pss.png"
squad <- "Spain" #Squad to download data from
date <- "18th June, 2021"
title <- "Spain VS Sweden"
cut_distance <-127

low = yellow_spain
high = red_spain



#download data of possession (function in functions)
stats <-download_possession(match_url = match_url,
                            squad = squad)

tot_km <- round(sum(stats$Tot_distance)/10e2,1)
subtitle <- glue("{squad} covered {tot_km}km with the ball controlled.")


#Plot
plot_distance(db = stats,
               fecha = date,
               title_label = title,
               subtitle_label = subtitle,
               color_low = low,
               color_high = high,
                cut_distance = cut_distance)

#export
exfile <- file.path("charts", png_name)

ggsave(exfile, last_plot(),
       dpi = 320,
       width = 13,
       height = 13)
