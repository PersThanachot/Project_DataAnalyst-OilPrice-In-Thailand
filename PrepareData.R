library(tidyverse)

#Import data excel.csv
OilPrice <- read.csv('C:/Users/Noter/Desktop/Data/OilPrice/Raw Data/OilPrice58_65.csv')
df = OilPrice

### Prepare Data ---------------------------------------------------------------
{
# Remove duplicate
df <- df %>% distinct(.keep_all = TRUE)

# '-' to NA
df[df == '-'] <- NA

# check if any missing values
mean(complete.cases(df)) 

# remove rows with NA
#df <- na.omit(df) 

## Change type data ------------------------------------------------------------
# Replace '/' to '-'
df$Date <- gsub('/','-',df$Date)
# Check type data
str(df)
# Change to Date
df$Date <- as.Date(df$Date,format = '%d-%m-%Y')
# Check type data again
str(df)

## Plot graph for overview -----------------------------------------------------
# Data frame set1
df1 = df
# Sort data
df1 <- df1[order(df1$Date), ]
# Plot graph 
ggplot(data = df1, 
       aes(x = Date, y = X95, group = 1)) +
  geom_line()

## Fix data problem ------------------------------------------------------------
# Select data (Don't use data error) 
df1 <- df %>% filter(Date >= '2560-05-09')

# Replace Data to correct
df1 %>% filter(Date == '2562-06-07')
df1$X95 <- replace(df1$X95, df1$Date == '2562-06-07', 27.35)

# Plot graph again
ggplot(data = df1, 
       aes(x = Date, y = X95, group = 1)) +
  geom_line() 
}
#### Analyst with Statistic ----------------------------------------------------
# mean
mean95 <- mean(df1$X95)
# median
median95 <- median(df1$X95)
# Standard Distribution
sd95 <- sd(df1$X95)
# Percentile 25 & 75
percentile <- quantile(df$X95,c(0.25,0.75))

# Plot graph with line
ggplot(data = df1, 
       aes(x = Date, y = X95, group = 1)) +
  geom_line() + 
  geom_hline(yintercept=percentile[1], 
             color = "red", size=1) +
  geom_hline(yintercept=percentile[2], 
             color = "blue", size=1)

# Normal Distribution
ggplot(data = df1,
       aes(x = X95)) +
  geom_histogram(aes(y = ..density..),
                 fill = "cornflowerblue", 
                 colour = 'black') +
  stat_function(fun = dnorm, 
                args = list(mean = mean95, sd = sd95), 
                colour = 'red',size = 1 )
