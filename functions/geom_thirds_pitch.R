#create thirds of pitch

geom_thirds_pitch <- function(color = "black"){
  
  list(
    geom_rect(
      data = filter(preasure_teams, name == "Def"),
      aes(xmin = 0, xmax = 32, ymin = 0, ymax = 100),
      color = 'black'
    ),
      geom_rect(
        data = filter(preasure_teams, name == "Mid"),
        aes(xmin = 32, xmax = 67.2, ymin = 0, ymax = 100),
        color = 'black'
      ),
      geom_rect(data = filter(preasure_teams, name == "Att"),
                aes(xmin = 67.2, xmax = 100, ymin = 0, ymax = 100),
                color = 'black'
      )
    
    
  )
  
  
}
