library(kableExtra)
library(readxl)
library(stringr)
library(ggplot2)
library(tidyverse)

# Read in raw data
data <- readxl::read_xlsx("NapoliBallersHistory.xlsx")

# Clean column names
names(data) <- str_to_lower(names(data))
names(data)[names(data) == 'pf/g'] <- "pfPerGame"
names(data)[names(data) == 'pa/g'] <- "paPerGame"
names(data)[names(data) == 'diff'] <- "pointDiff"

# Check owner names are unique
unique(data$owner)
table(data$owner, data$year)









paPlot <- ggplot(data, aes(x=pa))
paPlot + geom_density()


pfPlot <- ggplot(data, aes(x=pf))
pfPlot + geom_density() 
