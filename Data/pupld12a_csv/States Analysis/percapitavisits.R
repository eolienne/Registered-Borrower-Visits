#First download and unpack the dataset from here: http://www.imls.gov/research/pls_data_files.aspx

#configure the environment with appropriate packages

update.packages()
if("shiny" %in% rownames(installed.packages()) == FALSE) {install.packages("shiny", dependencies = TRUE)}
if("choroplethr" %in% rownames(installed.packages()) == FALSE) {install.packages("choroplethr", dependencies = TRUE)}
if("choroplethrMaps" %in% rownames(installed.packages()) == FALSE) {install.packages("choroplethrMaps", dependencies = TRUE)}
if("data.table" %in% rownames(installed.packages()) == FALSE) {install.packages("data.table", dependencies = TRUE)}

library(shiny)
library(choroplethr)
library(choroplethrMaps)
library(data.table)


setwd("C:/Users/Alyssa/Box Sync/Programming Projects/Library stats/pupld12a_csv")

#load data
states <- read.csv("states.csv")

#This was useful for figuring out which column number I wanted: match("VISITS", names(states))
#Cleaning up data to make it compatible with choropleths function
colnames(states)[84] <- "value"
colnames(states)[1] <- "region"
states$region <- tolower(state.name[match(states$region,state.abb)])
states$region[8] <- "district of columbia"

#Removing all of the remaining US territories from the data frame, since choroplethr doesn't accept them. Storing the result as a new dataframe.
states <- na.omit(states)

#Add column for percapita data
states$percapvisits <- states$value / states$POPU_UND

#This was useful for figuring out which column number I wanted: match("values", names(states))
match("value", names(states))
colnames(states)[84] <- "VISITS"
match("percapvisits", names(states))
colnames(states)[121] <- "value"

#Store the dataframe as a .rds object in a new Data directory, so that it can be easily called as a Shiny App
save(states, file="states.Rds")
load("states.Rds")

#Make a map of the raw total visits per state
state_choropleth(states, title="visits per capita by state",num_colors=1)
