library(tidyverse)

#Import data excel.csv
OilPrice <- read.csv('C:/Users/Noter/Desktop/Data/OilPrice/OilPrice58_65.csv')

df = OilPrice

## Prepare Data

# '-' to NA
df[df == '-'] <- NA

# check if any missing values
mean(complete.cases(df)) 

# remove rows with NA
#df <- na.omit(df) 

###########################################
#Date
df$Date <- gsub('/','-',df$Date)
df$Date <- as.Date(df$Date,format = '%d-%m-%Y')
str(df)
###########################################
#data frame set1
df1 = df
#Sort data
df1 <- df1[order(df1$Date), ]
#Plot graph
ggplot(data = df1, 
       aes(x = Date, y = X95, group = 1)) +
  geom_line()

###########################################
#Fix somthing

#Select data (Don't use data error) 
df1 <- df %>% filter(Date >= '2560-05-09')

#change Data to correct
df1 %>% filter(Date == '2562-06-07')
df1$X95 <- replace(df1$X95, df1$Date == '2562-06-07', 27.35)

#Plot graph
ggplot(data = df1, 
       aes(x = Date, y = X95, group = 1)) +
  geom_line()

