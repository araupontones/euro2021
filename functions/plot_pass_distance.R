#'plot distance covered and passess
#'@param db statistics of passes and possesion

plot_pass_distance <- function(db){
  
  p <- ggplot(db,
              aes(x = Tot_distance,
                  y = pass_attempted,
                  size = Touches
              )
  )+
    #invisible point to draw the legend
    geom_point(fill = NA,
               color = 'grey'
    )+
    #name of players ------------------------------------------------------
  geom_text_repel(aes(label = name_label),
                  size = 5,
                  family = font,
                  box.padding = 3, 
                  segment.curvature = -1e-20,
                  segment.ncp = 3,
                  segment.angle = 45,
                  color = 'white'
                  
  ) +
    #flags as points ----------------------------------------------------------
  geom_flag(aes(country = iso), show.legend = F) +
    scale_country() +
    scale_size(range = c(0, 30)
    ) +
    #labels -------------------------------------------------------------------
  labs(y = "Passes",
       x = "Distance with the ball controlled (in mts.)",
       subtitle = "Passes made and distance covered with the ball controlled by player.",
       title = title,
       caption = glue("Graphic: @AndresArau | Data: fbref.com | {fecha}")
  ) +
    #styles -------------------------------------------------------------------
  
  guides(size = guide_legend(label.position = "left", label.hjust = 1, title = "Ball touches")) +
    theme_pass_dist
  
  
  return(p)
  
}
