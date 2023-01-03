reports <- import(file.path(dir_data, "match_reports.rds"))

pressure <- reports %>%
  select(matches("def-Pressures-(Def|Mid|Att)"), match, country, date, Player) %>%
  filter(str_detect(match, "Italy")) %>%
  rename_at(vars(starts_with("def")), function(x){str_remove_all(x,"def-Pressures-| 3rd")})

names(pressure)

preasure_teams <- pressure %>%
  filter(str_detect(Player, "Player")) %>%
  pivot_longer(-c(match, date, country, Player))%>%
  mutate(value = as.numeric(value)) %>%
  group_by(name, country) %>%
  summarise(value = mean(value), .groups = 'drop') %>%
  mutate(img = here::here("images",paste0(country,".png ")),
         ref = glue('<a href="{img}"</a>'))




p <- ggplot(data = preasure_teams,
            aes(fill = value))+
  
  geom_thirds_pitch()+
  geom_cancha(color = "dimgray"
  )+
  scale_fill_gradient(low = 'white',high = '#CA4758',
                      name = "",
                      labels = function(x){paste0(x,"%")}) +
  labs(title = "Group A",
       caption = glue("Graphic: @AndresArau | Data: fbref.com | 23rd June, 2021"),
       subtitle = "From all the pressures, % of times that preassure was applied to an opposing<br>player in each 3rd of the pitch.") +
  facet_wrap(~country)+
  theme(panel.background = element_rect(fill = "#F5F4EF"),
        panel.grid = element_blank(),
        plot.background = element_rect(fill = "#F5F4EF"),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        legend.position = 'top',
        legend.key.width = unit(5, 'cm'), #change legend key width
        legend.background =  element_rect(fill = "#F5F4EF"),
        legend.text = element_text(size = 14),
        legend.title = element_text(vjust = .5),
        text = element_text(family= "IBM Plex Mono"),
        plot.title.position = 'plot',
        strip.text = element_markdown(size = 18, hjust = 0.2),
        strip.background = element_rect(fill = "#F5F4EF"),
        plot.title = element_text(size = 38, margin = margin(b = 15)),
        plot.subtitle =  element_markdown(size = 24, margin = margin(b =20), color = "#435761"),
        plot.caption = element_text(size = 16, margin = margin(t = 25, b = 15), hjust = 1)
        
  ) 


p + inset_element(flags_strip("it"), 0.02, 0.65, 0.1, .82, align_to = "full") +
  #strip left bottom
  inset_element(flags_strip("tr"), 0.02, 0.65, 0.1, .145, align_to = "full") +
  #strip right top
  inset_element(flags_strip("ch"), 0.9, 0.65, 0.19, .82, align_to = "full") 
  









#export
exfile <- file.path("charts", "grupoA_presion.png")

ggsave(exfile, last_plot(),
       dpi = 320,
       width = 17,
       height = 10)
