#flag strip for chart

flags_strip <- function(country){
  
  ggplot(data = d,
         aes(x = x,
             y = y)
  )+
    geom_flag(aes(country = country, x = .5, y = .5),
              size = 15) +
    theme_void() 
}