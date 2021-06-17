#' theme distancia
#' 
theme_distance <- theme(axis.text = element_text(family = "IBM Plex Mono", size = 16),
axis.ticks = element_blank(),
axis.text.x = element_text(margin = margin(t =10), size = 18),
axis.text.y = element_text(hjust = 0, size = 18),
axis.title.x =  element_text(margin = margin(t = 20), size = 19),
plot.background = element_rect(fill = "white"),
panel.background = element_rect(fill = "white"),
legend.position = "top",
legend.key.width = unit(2.5, 'cm'), #change legend key width
legend.title = element_text(vjust = 1, size = 24, hjust = 1, margin = margin(r = 15), colour = "grey"),
legend.text = element_text(size = 18),
text = element_text(family= "IBM Plex Mono"),
plot.caption = element_text(size = 16, margin = margin(t = 25, b = 15), hjust = 1),
plot.title = element_text(size = 32, hjust = 0.5),
plot.subtitle = element_text(size = 18, margin = margin(t = 5, b = 30), hjust = 0.5))
