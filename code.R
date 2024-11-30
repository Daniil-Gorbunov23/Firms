library(tidyverse)
library(data.table)
library(tidytable)
dataset_tbl <- 
  read_csv("OriginalDataset/Data.csv")

dataset_dttbl <-
  dataset_tbl|> as.data.table()


dataset_dttbl|> names()


#keep y k l18 sector year okato_regioncode services manuf

dataset_tbl |> 
  select(y_gr18, m18, k18, l18,sector18, year, okato_regioncode, services, manuf)


dataset_dttbl$okved4


library(dplyr)
library(dbplyr)

con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
copy_to(con, mtcars)
mtcars2 <- tbl(con, "mtcars")

summary <- mtcars2 %>% 
  group_by(cyl) %>% 
  summarise(mpg = mean(mpg, na.rm = TRUE)) %>% 
  arrange(desc(mpg))


summary %>% collect()
