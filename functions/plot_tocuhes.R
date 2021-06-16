
plot_touches <- function(db,
                         juego,
                         sub_titulo,
                         fecha,
                         color_squad,
                         nudge_image = 60,
                         nudge_player = 85,
                         ...){
 

  #define max number of touches
   max_touch <- max(db$Touches, na.rm = T)
  
  ggplot(data = db,
         aes(y = Touches,
             x = reorder(Player, Touches),
             image = image,
             fill = Touches)
  )  +
    geom_bar(stat = 'identity') +
    
    #name of the player-------------------------------------------------------
    geom_text(aes(label = name_label,
                  y = max_touch),
                  angle = 0,
                  nudge_y = nudge_player,
                  family = "IBM Plex Mono",
                  size = 8) +
    #% of touches  ---------------------------------------------------------
    geom_text(data = filter(db, perc_touches >.11),
              aes(label = scales::percent(perc_touches, accuracy = .1),
                  y = Touches - 10),
              color = "white",
              hjust = 0,
              nudge_x = -.2,
              family= "IBM Plex Mono",
              size = 5) +
    #face of player ------------------------------------------------------------
    geom_image(
      aes(y = max_touch),
      size = .05,
      nudge_y = nudge_image) +
    #polar coordinates --------------------------------------------------------
    coord_polar() +
    #legend --------------------------------------------------------------------
    scale_fill_gradient(low= "white", high=color_squad, 
                        limits=c(0,max_touch),
                        #labels = seq(0, max(stats$`Touches`) ,20),
                        name = "Ball touches"
    )+
    #labs ---------------------------------------------------------------------
    labs(x = "",
         y = "",
         caption = glue("Graphic: @AndresArau | Data: fbref.com | {fecha} "),
         title = juego,
         subtitle = sub_titulo) +
    theme_touches
    
  
  return(last_plot())
}
                
  
  


    
  


  
  
  




