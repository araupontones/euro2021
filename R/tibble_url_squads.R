url <- 'https://fbref.com/en/comps/676/UEFA-Euro-Stats'


website <- read_html(url)




#get url of squads-----------------------------------------------------------


raw <- tibble(
url = website %>%
  html_elements("#results102780_overall") %>%
  html_elements("a") %>%
  html_attr("href"),
  
  
country =website %>%
    html_elements("#results102780_overall") %>%
    html_elements("a") %>%
    html_text()
)


#clean ------------------------------------------------------------------------
clean <- raw %>%
  dplyr::filter(str_detect(url,"squad")) %>%
  mutate(id_country = str_extract(url, "(?<=squads\\/)(.*)(?=\\/)"),
         url = paste0("https://fbref.com", url),
         country = str_replace(country, " ", "-"))
View(clean)

export(clean, file.path(dir_data, "url_squads.rds"))
