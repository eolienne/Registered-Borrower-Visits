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
counties <- read.csv("counties.csv")
counties2 <- read.csv("counties2.csv")

#Make data directory for shiny app

dir.create("New project")
setwd("C:/Users/Alyssa/Box Sync/Programming Projects/Library stats/pupld12a_csv/New project")
dir.create("Data")
setwd("C:/Users/Alyssa/Box Sync/Programming Projects/Library stats/pupld12a_csv/New project/Data")

#Store the dataframe as a .rds object in a new Data directory, so that it can be easily called as a Shiny App
save(counties, file="counties.Rds")
load("counties.Rds")
save(counties2, file="counties2.Rds")
load("counties2.Rds")

#First you need to convert data frame to a data table
counties2 <- data.table(counties2)

#Many libraries have -1 as an ebook total. This will affect creating the sums. Need to change all of the negative values to 0.
counties2[counties2$EBOOK<0] <- 0

#County numbers ($FIPSCO) need to be three digits long. Prepend zeros
counties2$FIPSCO <- formatC(counties2$FIPSCO, width=3, format="d",flag="0")


#Data for location needs to be fixed
counties2$FIPSCO <- sprintf("%d%s", counties2$FIPSST,counties2$FIPSCO)

#Sum of all ebooks per county and create a new data frame for that data
#For more detail on how this works: http://rprogramming.net/aggregate-data-in-r-using-data-table/
ebooks <- as.data.frame(counties2[,sum(EBOOK,na.rm=TRUE), by=FIPSCO])

#Rename columns to work with map
colnames(ebooks)[2] <- "value"
colnames(ebooks)[1] <- "region"

#Not sure why region values are characters instead of numerics, but that needs to change.
ebooks$region <- as.numeric(ebooks$region)

#Make a map!
county_choropleth(ebooks, title="Total ebooks per county", num_colors = 9, state_zoom=NULL, county_zoom = NULL)
