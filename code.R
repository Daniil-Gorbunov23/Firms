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

