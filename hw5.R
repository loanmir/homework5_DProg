library(readr)
library(tidyverse)
library(ggplot2)
dataset <- read.csv("dataset.csv", sep = ";")
state_abrv_pop <- read.csv("state_abbreviations_and_populations.csv", sep = ";")

state_abrv_pop
colnames(state_abrv_pop)
# exercise number 1 
#a) show number of fatalities per state:
data_merged <- inner_join(state_abrv_pop, dataset, by = c("Abbreviation" = "State"))

fatalities_state <- data_merged %>% group_by(State = .$Name.x) %>%
  summarise(n = n())
fatalities_state
#b)
ggplot(fatalities_state, aes(x = n, y = State)) +
  geom_histogram(stat = "identity") +
  labs(title = "Fatalities per State",
       x = "count",
       y = "State")


# exercise number 2
gender_raceData <- dataset %>% group_by(Gender, Race) %>% summarise(n = n(), .groups = 'drop')
ggplot(gender_raceData, aes(x = n, y = Race))+
  geom_col() +
  facet_wrap(~Gender, scales = "free_x")+
  labs(x = "count", y = "Race") 
 


# exercise number 3
# Plot the outline of the USA by scatterplotting the locations of deaths
dataset <- dataset %>% mutate(LongitudeNew = as.numeric(Longitude),
                              LatitudeNew = as.numeric(Latitude))
dataset_clean <- dataset %>% filter(!is.na(LongitudeNew) & !is.na(LatitudeNew))
ggplot(dataset_clean, aes(x = LongitudeNew, y = LatitudeNew)) +
  geom_point(color = "black")+
  labs(x = "Longitude",
       y = "Latitude")+
  theme_minimal()
