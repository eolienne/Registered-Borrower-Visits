#Make sure that the correct R packages are installed on computer
if("Rcpp" %in% rownames(installed.packages()) == FALSE) {install.packages("Rcpp", dependencies = TRUE)}
if("shiny" %in% rownames(installed.packages()) == FALSE) {install.packages("shiny", dependencies = TRUE)}
if("maps" %in% rownames(installed.packages()) == FALSE) {install.packages("maps", dependencies = TRUE)}
if("mapproj" %in% rownames(installed.packages()) == FALSE) {install.packages("mapproj", dependencies = TRUE)}
if("choroplethr" %in% rownames(installed.packages()) == FALSE) {install.packages("choroplethr", dependencies = TRUE)}

#Activate those packages for this environment
library(Rcpp)
library(maps)
library(mapproj)
library(shiny)
library(choroplethr)

#Start to load the data

setwd("C:/Users/Alyssa/Box Sync/Programming Projects/Library stats/pupld12a_csv")
df <- read.csv(file="Pusum12a.csv")

#Cleaning up data to make it compatible with choropleths function
colnames(df)[88] <- "value"
colnames(df)[1] <- "region"
df$region <- tolower(state.name[match(df$region,state.abb)])
df$region[8] <- "district of columbia"

#Removing all of the remaining US territories from the data frame, since choroplethr doesn't accept them. Storing the result as a new dataframe.
states <- na.omit(df)

#Save the resulting dataframe as a .Rds file in a new Data directory
dir.create("Data")
setwd("C:/Users/Alyssa/Box Sync/Programming Projects/Library stats/pupld12a_csv/Registered borrowers/Data")
save(states, file="states.Rds")
load("states.Rds")

#Make a new column to store the percentage of population as registered borrowers
states["PERCENT_REGBOR"] <- NA

#Populating it with percentage of population as registered borrowers
states$PERCENT_REGBOR <- states$value / states$POPU_UND

#Explore this data
states$PERCENT_REGBOR

#convert these values into percentages
## This code seemed to break the state_choropleth function. Unsure why.
#states$PERCENT_REGBOR <- paste(round((states$PERCENT_REGBOR)*100,digits=1),sep="")


#In order to generate a new map, the new column must be renamed as "value"
colnames(states)[88] <- "REGBOR"
colnames(states)[121] <- "value"

#Display new choropleth of percentage of population as registered borrowers
state_choropleth(states, title="2012: Percentage of state population as registered library borrowers", "Percents", num=1)
