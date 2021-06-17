#plot distance
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
library(cowplot)



#define paramenters
match_url <- "https://fbref.com/en/matches/95d34c87/France-Germany-June-15-2021-UEFA-Euro"
png_name <- "France_vs_germany.png"
squad <- "France" #Squad to download data from
date <- "15th June, 2021"
title <- "France VS Germany"
subtitle <- "France covered 1.3km with the ball controlled."
low = red_france
high = blue_france



#download data of possession (function in functions)
stats <-download_possession(match_url = match_url,
                            squad = squad)


#Plot
plot_distance(db = stats,
               fecha = date,
               title_label = title,
               subtitle_label = subtitle,
               color_low = low,
               color_high = high)

#export
exfile <- file.path("charts", png_name)

ggsave(exfile, last_plot(),
       dpi = 320,
       width = 13,
       height = 13)
