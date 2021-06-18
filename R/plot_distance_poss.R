
load_functions(dir_style)


match_url <- "https://fbref.com/en/matches/caa84313/Italy-Switzerland-June-16-2021-UEFA-Euro"
fecha <- "18th June, 2021"
squads <- c("Italy","Switzerland") #Squad to download data from



#pre-filled --------------------------------------------------------------------
title <- glue("{squads[1]} VS {squads[2]}")#cut_distance <-127
png_name <- glue("{title}_passess.png")




stats_list <- purrr::map(squads, download_passes_possession)
stats <- do.call(rbind, stats_list)

stats <- stats %>%
  mutate(iso = case_when(squad =="Italy" ~ "it",
                         squad == "Switzerland" ~ "ch"))


stats %>%
  group_by(squad) %>%
  summarise(passes= sum(pass_attempted),
            distance = sum(Tot_distance))



plot_pass_distance(stats)


#export
exfile <- file.path("charts", png_name)

ggsave(exfile, last_plot(),
       dpi = 320,
       width = 13,
       height = 13)         
            