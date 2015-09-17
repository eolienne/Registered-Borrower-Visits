#First download and unpack the dataset from here: http://www.imls.gov/research/pls_data_files.aspx

#configure the environment with appropriate packages

update.packages()
if("shiny" %in% rownames(installed.packages()) == FALSE) {install.packages("shiny", dependencies = TRUE)}
if("choroplethr" %in% rownames(installed.packages()) == FALSE) {install.packages("choroplethr", dependencies = TRUE)}
if("choroplethrMaps" %in% rownames(installed.packages()) == FALSE) {install.packages("choroplethrMaps", dependencies = TRUE)}
if("data.table" %in% rownames(installed.packages()) == FALSE) {install.packages("data.table", dependencies = TRUE)}
if("googleVis" %in% rownames(installed.packages()) == FALSE) {install.packages("googleVis", dependencies = TRUE)}



library(shiny)
library(choroplethr)
library(choroplethrMaps)
library(data.table)
library(googleVis)


setwd("C:/Users/Alyssa/Box Sync/Programming Projects/Library stats/pupld12a_csv")

#load data
states <- read.csv("states.csv")

#This was useful for figuring out which column number I wanted: match("VISITS", names(states))
#Cleaning up data to make it compatible with choropleths function
colnames(states)[84] <- "value"
colnames(states)[1] <- "region"
states1$region <- tolower(state.name[match(states$region,state.abb)])
states1$region[8] <- "district of columbia"

#Removing all of the remaining US territories from the data frame, since choroplethr doesn't accept them. Storing the result as a new dataframe.
states <- na.omit(states)

#Add column for registered borrower data
states1$regborvisits <- states1$value / states1$REGBOR

#This was useful for figuring out which column number I wanted: match("values", names(states))
match("value", names(states))
colnames(states)[84] <- "VISITS"
match("regborvisits", names(states))
colnames(states)[121] <- "Annual public library visits per registered borrower"

require(datasets)
states2 <- data.frame(states1$region, states1$`Annual public library visits per registered borrower`)
GeoStates <- gvisGeoChart(states2, states$region, states$`Annual public library visits per registered borrower`,
                          options=list(region="US", 
                                       displayMode="regions", 
                                       resolution="provinces",
                                       width=600, height=400))
plot(GeoStates)
