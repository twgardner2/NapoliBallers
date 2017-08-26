library(readxl)
library(stringr)
library(ggplot2)
library(tidyverse)

# Read in raw data
data <- readxl::read_xlsx("NapoliBallersHistory.xlsx")

# Check owner names are unique
unique(data$Owner)
