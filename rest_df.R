library(tidyverse)
library(ggplot2)
rest_df <- readr::read_csv("zomato.csv")
country_code <-  readr::read_csv('country_code.csv')
names(rest_df)
names(country_code)
#lower all the columns names & add _
names(rest_df) <-  tolower(names(rest_df))
names(rest_df) <-  gsub(' ', '_', names(rest_df))
names(rest_df)

#look at whats a chr or int
summary(rest_df)
#restruant_id, country_code, price_range should be chr vectors
#merge country codes
#change all 0 to NA
rest_df[rest_df == 0] <- NA
rest_df[!complete.cases(rest_df),]
View(rest_df)
summary(rest_df)



View(rest_df[!complete.cases(rest_df),])
# get rid of all rows of which aggregate rating == NA
rest_df <- rest_df[!is.na(rest_df$aggregate_rating),]
View(rest_df)

rest_df[!complete.cases(rest_df),]
rest_df
rest_df <- left_join(rest_df, country_code, by = c('country_code' = 'Country Code'))
View(rest_df)


#select columns I plan on using such as:
#restruant_name, country code, city, address, locality, long, lat, cuisine, average cost for two, currency, price range, 
#aggregate_rating, rating text, votes

#drop rest ID, has online ordering, delivery, switch to order menu, rating color

rest_df2 <-  rest_df %>%  select(., -restaurant_id, -has_online_delivery, -is_delivering_now, -switch_to_order_menu, -rating_color)
rest_df2 <- rest_df2 %>% rename(., country = Country)

rest_df2$rating_text <- as.factor(rest_df2$rating_text)
levels(rest_df2$rating_text)
rest_df2$rating_text <- factor(rest_df2$rating_text, levels = c('Excellent', 'Very Good', 'Good', 'Average', 'Poor'))
levels(rest_df2$rating_text)
uniq_rest <-  unique(rest_df2)

rest_df2 %>% filter(., country=='Brazil') %>% summarise(., avg = mean(aggregate_rating))

View(rest_df2)
#graphs to makes
#1. Rating by country
#which country has the best food ratings according to zomato
names(rest_df2)
unique(rest_df2$cuisines)


g <- ggplot(data = uniq_rest) + geom_bar(aes(x= country, fill = rating_text, color = country))
g
#2. Rating by cuisine
#which cuisine is the most popular through all the countries


#3. top cuisines in every country
#list top 5
#show on map

#4. top 20 restruants in the top 5 cuisines in every country
#list and show on map

#5catterplot of price and country