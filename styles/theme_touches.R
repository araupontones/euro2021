#theme touches

theme_touches <- theme(axis.text = element_blank(),
                       axis.ticks = element_blank(),
                       plot.background = element_rect(fill = "white"),
                       panel.background = element_rect(fill = "white"),
                       legend.position = "top",
                       legend.key.width = unit(2.5, 'cm'), #change legend key width
                       legend.title = element_text(vjust = 1, size = 24, hjust = 1, margin = margin(r = 15), colour = "grey"),
                       legend.text = element_text(size = 18),
                       text = element_text(family= "IBM Plex Mono"),
                       plot.caption = element_text(size = 16),
                       plot.title = element_text(size = 32),
                       plot.subtitle = element_text(size = 18, margin = margin(t = 5, b = 30)))