library(RColorBrewer)
library(kableExtra)
library(readxl)
library(stringr)
library(ggplot2)
library(tidyverse)
library(knitr)

# Read in raw data
data <- readxl::read_xlsx("NapoliBallersHistory.xlsx")

# Clean columns
names(data) <- str_to_lower(names(data))
names(data)[names(data) == 'pf/g'] <- "pfPerGame"
names(data)[names(data) == 'pa/g'] <- "paPerGame"
names(data)[names(data) == 'diff'] <- "pointDiff"
data$year <- as.character(data$year)



# Check owner names are unique
unique(data$owner)





# Make owner participation table
ownerTable <- data %>% 
  group_by(owner) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count), owner)

# Find unique years and owners
years <- unique(as.character(data$year))
owners <- unique(data$owner)

# Build ownerTable
for (y in years) {
  ownerTable[[y]] <- " " 
}

# Populate ownerTable
for (col in 3:ncol(ownerTable)) {
  for (row in 1:nrow(ownerTable)) {
    years_compare <- unlist(data %>% filter(owner == as.character(ownerTable[row,1])) %>% select(year))
    ownerTable[row,col] <- ifelse(  years[col-2] %in% unlist( years_compare ) ,"X"," ")
  }
}

kable(ownerTable, table.attr = "id=\"ownertable\"")



# Summarize results
rankTable <- data %>% count(owner, rank)  %>% filter(rank<=3)
rankTable <- rankTable %>% spread(key = rank, value = n, fill = 0)
newNames <- c("owner", "1st Place", "2nd Place", "3rd Place")
colnames(rankTable) <- newNames

winsTable <- data %>% group_by(owner) %>% summarize(Wins = sum(w), Losses = sum(l), Ties = sum(tie))  

performanceTable <- full_join(rankTable, winsTable, by="owner") %>% mutate_all(funs(replace(., which(is.na(.)), 0)))

kable(performanceTable, table.attr = "id=\"performancetable\"")



pfData <- data %>% filter(!is.na(pfPerGame))
pfPlot <- ggplot(pfData, aes(x=pfPerGame, fill=owner))
pfPlot + geom_histogram(aes(color=factor(ifelse(rank==1,1,0)))) + scale_color_manual(values = c("black", "red"))

#+ scale_fill_brewer(length(unique(data$owner)), palette="Spectral")



paPlot + geom_density()
paPlot + geom_bar()



pfPlot <- ggplot(data, aes(x=pf))
pfPlot + geom_density() 
