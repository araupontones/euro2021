#plots a futbol pitch

annotate_circle <- function(x, y, r, color, fill) {
  ggplot2::annotation_custom(
    grob = grid::circleGrob(gp = grid::gpar(col  = color, fill = fill, lwd  = 1.5)),
    xmin = x - r,
    xmax = x + r,
    ymin = y - r,
    ymax = y + r
  )
  
}


geom_cancha <- function(color = "dimgray",
                        size = .5,
                        fill = NA#alpha("white", .1)
                        ){
  list(
    #limites del campo
    ggplot2::annotate("rect",
                      xmin = 0,
                      xmax = 100,
                      ymin = 0,
                      ymax = 100,
                      color =color,
                      fill = fill,
                      size = size),
    
    
    #area izquierda ---------------------------------------------------------------
    ggplot2::annotate("rect",
                      ymin = 22.5,
                      ymax = 77.5,
                      xmin = 0,
                      xmax = 16.5,
                      fill = fill,
                      color = color,
                      size = size) ,
    #area chica izquierda
    ggplot2::annotate("rect",
                      ymin = 37.5,
                      ymax = 62.5,
                      xmin = 0,
                      xmax = 5.5,
                      fill = fill,
                      color = color,
                      size = size) ,
    #punto de penal izquierdo
    ggplot2::annotate("point",
                      x = 11,
                      y = 50,
                      color = color) ,
    #area derecha ---------------------------------------------------------------
    ggplot2::annotate("rect",
                      ymin = 22.5,
                      ymax = 77.5,
                      xmin = 83.5,
                      xmax = 100,
                      fill = fill,
                      color = color,
                      size = size) ,
    #area chica derecha
    ggplot2::annotate("rect",
                      ymin = 37.5,
                      ymax = 62.5,
                      xmin = 94.5,
                      xmax = 100,
                      fill = fill,
                      color = color,
                      size = size) ,
    #punto de penal izquierdo
    ggplot2::annotate("point",
                      x = 89,
                      y = 50,
                      color = color) ,
    #centro del campo -----------------------------------------------------------
    ggplot2::annotate("segment",
                      x = 50,
                      xend = 50,
                      y = 0,
                      yend =  100,
                      color = color,
                      size = size
    ) ,
    annotate_circle(
      x      = 50,
      y      = 50,
      r      = 18,
      color = color,
      fill   = fill
    )
    # ggplot2::annotate("point",
    #                   x = 50,
    #                   y = 50,
    #                   size = 2,
    #                   color = color) 
  )
}
