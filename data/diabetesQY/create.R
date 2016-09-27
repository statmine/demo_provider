library(dplyr)

data <- read.csv("../diabetes/data.csv")

data <- 
  data %>% 
  rename(periode = jaar) %>% 
#  filter(leeftijd == "Totaal", geslacht=="Totaal") %>%
  mutate(periode = as.character(periode)) %>% 
  select(periode, leeftijd, geslacht, suiker)


data_q <- lapply(1:4, function(quarter){
  data$periode <- paste0(data$periode, "Q", quarter)
  data$suiker <- data$suiker + round(rnorm(n=nrow(data), sd=0.2), 1)
  data
})

D <- 
  do.call(bind_rows, data_q) %>% 
  bind_rows(data) 

write.csv(D, "data.csv", row.names = FALSE, quote = FALSE)
