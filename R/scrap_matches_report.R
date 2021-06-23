
#Downloads all the match reports of Uefa 2021


#import old_reports -----------------------------------------------------------
squads <- import(file.path(dir_data, "url_squads.rds"))
old_reports <- import(file.path(dir_data, "match_reports.rds"))


#define countries and download--------------------------------------------------
countries<- squads$country
#countries <- c("Spain")
new_report_list <- purrr::map(countries, download_report)
new_report_data <- do.call(rbind,new_report_list)


#append with old report ands export (if data was downloaded)

if(length(new_report_data) >0){
  
  appended_report <- rbind(old_reports, new_report_data)
  export(appended_report, file.path(dir_data, "match_reports.rds"))
  #export file to Rigel
  export(appended_report, file.path(dir_data, "match_reports.xlsx"), encoding ="utf-8")
  
  
  
} else{
  
  message("No new records")
}

ncol(appended_report)





length(unique(appended_report$Player))
