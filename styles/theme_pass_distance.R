theme_pass_dist <- theme(
  
  #Axis -----------------------------------------------------------------  
  axis.text = element_text(family = "IBM Plex Mono", size = 16, color = "white"),
  axis.ticks = element_blank(),
  axis.text.x = element_text(margin = margin(t =10), size = 18),
  axis.text.y = element_text(hjust = 0, size = 18),
  axis.title = element_text(color = "white", family = font, size = 20),
  axis.title.x =  element_text(margin = margin(t = 20)),
  axis.title.y = element_text(margin = margin(r = 20)),
  axis.line = element_line(color = 'grey', size = 2),
  #background -----------------------------------------------------------
  plot.background = element_rect(fill = "black"),
  panel.background = element_rect(fill = "black"),
  # #legend ----------------------------------------------------------------
  legend.background = element_rect(fill = "black"),
  legend.key = element_rect(fill = "black"),
  legend.position = "top",
  legend.text.align = 1,
  legend.key.width = unit(2, 'cm'), #change legend key width
  legend.title = element_text(vjust = .5, size = 24, hjust = 1, margin = margin(r = 15), colour = "grey", family = font),
  legend.text = element_text(size = 18, color = "grey", family = font),
  
  #labesl -----------------------------------------------------------------
  plot.title = element_text(size = 32, hjust = 0.5, color = "white"),
  plot.subtitle = element_text(size = 18, margin = margin(t = 5, b = 30), hjust = 0.5),
  plot.caption = element_text(size = 16, margin = margin(t = 25, b = 15), hjust = 1),
  panel.grid = element_blank(),
  text = element_text(family = font, color = "white")
)
