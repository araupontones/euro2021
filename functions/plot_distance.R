#' plot distance with the ball controlled
#' @param db A tibble with the stats of the match
#' @param fecha Date of the chart (25th June, 2021)
#' @param title_label Title of the chart
#' @param subtitle_label Subtitle of the chart



plot_distance <- function(db,
                          fecha = "15th June, 2021",
                          title_label = "France VS Germany",
                          subtitle_label = "France covered 1.3km with the ball controlled.",
                          color_low,
                          color_high,
                          ...
){
  
  
  #define parameters of the charts --------------------------------------------
  max_distance <-  max(db$Tot_distance) 
  nudge_pic <-max_distance *.05
  xlim <-round(max_distance + nudge_pic + 10)
  

  
  #plot ------------------------------------------------------------------------
  
  
  
  plot <-ggplot(data = filter(db,Tot_distance >0),
                aes(x = Tot_distance,
                    y = reorder(Player, Tot_distance),
                    fill = Tot_distance
                )
  ) +
    #bars ---------------------------------------------------------------------
    geom_col(width = .8) +
    geom_text(aes(label = paste0(round(Tot_distance),"mts."),
                  x = Tot_distance
    ),
    hjust = 1,
    color = "white",
    family = "IBM Plex Mono",
    size = 12
    ) +
    #image of player ----------------------------------------------------------
    geom_image(aes(image = image),
               nudge_x = nudge_pic,
               size = .07
               )+
    #styles -------------------------------------------------------------------
    scale_fill_gradient(low = color_low,
                        high = color_high,
                        name = "Distance with the ball"
                        ) +
    xlim(c(0,xlim)) +
    labs(y = "",
         x = "Total distance with the ball (in meters)",
         caption = glue("Graphic: @AndresArau | Data: fbref.com | {fecha} ")
    ) +
    theme_distance
  
  
  
  
  #title-----------------------------------------------------------------------
  title <- ggplot() +
    xlim(0,1) +
    ylim(0,1)+
    geom_text(aes(x = 0, y = .9, label = title_label), family = "IBM Plex Mono", size = 12, hjust =0) +
    theme_void() +
    theme(plot.margin = unit(c(0, 0, -10, 0), "cm"))
  
  #subtitle ------------------------------------------------------------------
  subtitle <- ggplot() +
    xlim(0,1) +
    ylim(0,1)+
    geom_text(aes(x = 0, y = .9, label = subtitle_label), family = "IBM Plex Mono", size = 8, hjust =0)+
    theme_void() +
    theme(plot.margin = unit(c(0, 0, 0, 0), "cm"))
  
  
  
  
  
  final_plot <- cowplot::plot_grid(title, subtitle, plot, rel_heights = c(0.1, 0.1, 1), ncol = 1)
  
 
  
  return(final_plot)
  
  
}
