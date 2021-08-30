library(tidyverse)
library(maps)
library(ggthemes)
library(mapproj)

county <- read.csv("co-est2019-alldata.csv")
county <- county %>%
  select(STNAME, CTYNAME, BIRTHS2019)
head(county)

countymapdata <- map_data("county", "ohio")

countymap <- ggplot(county) +
  geom_path(aes(x = long, y = lat, group = group), data = countymapdata)
countymap

countymap +
  coord_map(projection = 'lambert', lat0 = 33, lat1 = 45)
theme_map()

pop_data <- read_csv("co-est2019-alldata.csv")
library(stringr)
ohio_pop_data <- pop_data %>% 
  filter(STATE==39) %>% 
  select(STNAME,CTYNAME,BIRTHS2019)
ohio_pop_data <- ohio_pop_data[-1,] %>%
  rename(county = CTYNAME, state = STNAME, births = BIRTHS2019) %>%
  mutate(county = tolower(county),
         state = tolower(state)) %>%
  mutate(county = str_replace_all(county, ' county', ''))
head(ohio_pop_data)

ohiocountymapdata <- left_join(countymapdata, ohio_pop_data, by = c("subregion" = "county"))
head(ohiocountymapdata)

ggplot(ohiocountymapdata) +
  geom_polygon(aes(x = long, y = lat, group = group, fill = births), data = ohiocountymapdata) + 
  labs(title = "Ohio Births in 2019 by County", caption = "Data Source: United States Census Bureau") +
  scale_fill_gradient(low = "orchid", high = "mediumpurple4") +
  theme(plot.title = element_text(hjust = 0.5))
