library(tidyverse) 
library(XML)
library(rvest)

#Create empty location
reviews <- character()

#For Loop
for(reviews_pages in 2015:2022){
  
  link = paste0('url', reviews_pages)
  # read link
  pages = read_html(link)
  # find table in website
  page_review <- pages %>% html_table()
  # [1] table[1], [2] table[2], ... ,[N] table[N]
  reviews <- c(reviews, page_review)
  # Print if complete one loop
  print("Scraping reviews in progress")  
}

#list to dataframe & combine
df <- do.call(rbind.data.frame, reviews)

#Rename column
names(df)[1] <- 'Date'
names(df)[2] <- 'Premium_Diesel_B7'
names(df)[3] <- 'Diesel_B7'
names(df)[4] <- 'Diesel'
names(df)[5] <- 'Diesel_B20'
names(df)[6] <- 'E85'
names(df)[7] <- 'E20'
names(df)[8] <- '91'
names(df)[9] <- '95'
names(df)[10] <- 'NGV'

#Output Dataframe to excel.csv
write.csv(df,"location file/excel.csv", row.names = FALSE)
