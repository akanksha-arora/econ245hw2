library(tidyverse)
library(readr)
library(dplyr)

airbnb <- read_csv("assign_2.csv")
airbnb <- tibble(airbnb)
view(airbnb)
colnames(airbnb)
airbnb <- rename(airbnb, neighborhood=neighbourhood)

neighborhoods <- airbnb %>% count(neighborhood)
neighborhoods <- filter(neighborhoods, !is.na(neighborhood)) %>% arrange(desc(n)) %>% head(n=20)
airbnb_top_neighborhoods <- filter(airbnb, neighborhood %in% neighborhoods$neighborhood)
summary_stats_top_neighborhoods <- airbnb_top_neighborhoods %>% group_by(neighborhood) %>% 
  summarise(avg_square_feet=mean(square_feet, na.rm=T), 
            avg_price=mean(price, na.rm=T), 
            sd_price=sd(price, na.rm=T), 
            max_price=max(price, na.rm=T), 
            min_price=min(price, na.rm=T)) %>% arrange(desc(avg_square_feet))

# No, square footage is not the only variable that matters for price.