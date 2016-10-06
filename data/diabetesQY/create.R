library(dplyr)

data <- read.csv("../diabetes/data.csv")

data <- 
  data %>% 
  rename(periode = jaar) %>% 
#  filter(leeftijd == "Totaal", geslacht=="Totaal") %>%
  mutate(periode = as.character(periode)) %>% 
  select(periode, leeftijd, geslacht, suiker)


set.seed(42)
data_q <- lapply(1:4, function(quarter){
  data$periode <- paste0(data$periode, "Q", quarter)
  data$suiker <- data$suiker + round(rnorm(n=nrow(data), sd=0.2), 1)
  data
})

D <- 
  do.call(bind_rows, data_q) %>% 
  bind_rows(data) %>% 
  arrange(periode)

write.csv(D, "data.csv", row.names = FALSE, quote = FALSE)

library(jsonlite)

cat_period <-
  D %>% 
  select(name=periode) %>% 
  distinct() %>% 
  mutate( title=name,
          title=sub("Q", " kwartaal ", title)
        ) %>% 
  glimpse

dp <- readLines("../diabetes/datapackage.json") %>% fromJSON(simplifyDataFrame = F)
# first fields is period field
dp$resources[[1]]$schema$fields[[1]]$categories <- cat_period
dp$resources[[1]]$schema$fields[[1]]$name <- "periode"
dp$resources[[1]]$schema$fields[[1]]$title <- "Periode"

dp %>% toJSON(auto_unbox = TRUE, pretty = TRUE) %>% writeLines("datapackage.json")
