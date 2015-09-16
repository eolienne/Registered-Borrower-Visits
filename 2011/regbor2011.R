#First download and unpack the dataset from here: http://www.imls.gov/research/pls_data_files.aspx --> now it is: http://imls.gov/research-evaluation/data-collection/public-libraries-united-states-survey/public-libraries-united 


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

setwd("C:/Users/Alyssa/Box Sync/Programming Projects/IMLS Data/Registered-Borrower-Visits/2011")

#load data
states <- read.csv("pusum11b.csv")

#This was useful for figuring out which column number I wanted: match("VISITS", names(states))
#Cleaning up data to make it compatible with choropleths function
valuecolnum <- match("VISITS", names(states))
regioncolnum <- match("STABR", names(states))
colnames(states)[valuecolnum] <- "value"
colnames(states)[regioncolnum] <- "region"
states$region <- tolower(state.name[match(states$region,state.abb)])

#Choroplethr is expecting Washington, DC so I make sure that is included
states$region[8] <- "district of columbia"

#Removing all of the remaining US territories from the data frame, since choroplethr doesn't accept them. Storing the result as a new dataframe.
states <- na.omit(states)

#Add column for registered borrower data
states$regborvisits <- states$value / states$REGBOR

colnames(states)[valuecolnum] <- "VISITS"
regborvisits <- match("regborvisits", names(states))

#one of the columns needs to be value
colnames(states)[regborvisits] <- "value"

#Make a map of the raw total visits per state
state_choropleth(states, title="visits per registered borrower: 2011",num_colors=1)
