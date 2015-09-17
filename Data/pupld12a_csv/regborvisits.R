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

#Add column for registered borrower data
states$regborvisits <- states$value / states$REGBOR

#This was useful for figuring out which column number I wanted: match("values", names(states))
match("value", names(states))
colnames(states)[84] <- "VISITS"
match("regborvisits", names(states))
colnames(states)[121] <- "value"

#Make a map of the raw total visits per state
state_choropleth(states, title="visits per registered borrower",num_colors=1)

#List the top couple of visits per registered borrower states
liststates <- subset(states, value > 12)[, c("region", "value")]
liststates <- data.table(liststates)
setorder(liststates, -value)

#List the bottom few states with the lowers number of visits per registered borrower
liststates2 <- subset(states, value < 7 )[, c("region", "value")]
liststates2 <- data.table(liststates2)
setorder(liststates2, -value)
