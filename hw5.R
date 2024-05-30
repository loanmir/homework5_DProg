library(readr)
library(tidyverse)
library(ggplot2)
dataset <- read.csv("dataset.csv", sep = ";")
View(dataset)
state_abrv_pop <- read.csv("state_abbreviations_and_populations.csv", sep = ";")

state_abrv_pop
colnames(state_abrv_pop)
# exercise number 1 
#a) show number of fatalities per state:
data_merged <- inner_join(state_abrv_pop, dataset, by = c("Abbreviation" = "State"))

fatalities_state <- data_merged %>% group_by(State = .$Name.x) %>%
  summarise(n = n())
#b)
ggplot(fatalities_state, aes(x = n, y = State)) +
  geom_histogram(stat = "identity") +
  labs(title = "Fatalities per State",
       x = "count",
       y = "State")


# exercise number2

