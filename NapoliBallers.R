library(readxl)
library(stringr)
library(ggplot2)
library(tidyverse)

# Read in raw data
path <- "C://Users//Tom//Documents//R//NapoliBallers//"
data <- readxl::read_xlsx(str_c(path, "NapoliBallersHistory.xlsx"))

# Check owner names are unique
unique(data$Owner)
