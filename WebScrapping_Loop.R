library(tidyverse) 
library(XML)
library(rvest)

reviews <- character()
#For Loop
for(reviews_pages in 2015:2022){
  
  Link = paste0('https://www.bangchak.co.th/th/oilprice/historical?year=', reviews_pages)
  
  pages = read_html(Link)
  page_review <- pages %>% html_table()
  
  reviews <- c(reviews, page_review)
  
  print("Scraping reviews in progress")  
}


df <- do.call(rbind.data.frame, reviews)

