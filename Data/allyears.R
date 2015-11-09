#Already downloaded all zip files for csv from this site: http://imls.gov/research-evaluation/data-collection/public-libraries-united-states-survey/public-libraries-united 
#This script will generate one saved data frame that has the states and the visits per registered borrower for several years.


update.packages()
if("shiny" %in% rownames(installed.packages()) == FALSE) {install.packages("shiny", dependencies = TRUE)}
if("choroplethr" %in% rownames(installed.packages()) == FALSE) {install.packages("choroplethr", dependencies = TRUE)}
if("choroplethrMaps" %in% rownames(installed.packages()) == FALSE) {install.packages("choroplethrMaps", dependencies = TRUE)}
if("data.table" %in% rownames(installed.packages()) == FALSE) {install.packages("data.table", dependencies = TRUE)}
if("plyr" %in% rownames(installed.packages()) == FALSE) {install.packages("plyr", dependencies = TRUE)}

#Trying a script to go through all of the years of PLS files
#Compute per regbor visits then append it to end of data frame with column name of year

library(choroplethr)
library(data.table)
library(choroplethrMaps)
library(plyr)
update.packages()

data_columns = c("STABR", "VISITS", "REGBOR")

region_abbr = c(state.abb, "DC")
region_name = c(state.name, "District of Columbia")

setwd("C:/Users/Alyssa/Box Sync/Programming Projects/IMLSdata/Registered-Borrower-Visits/Data")

#Force R to not use exponential notation
options(scipen=999)
#Each year is currently stored in its own folder. Each folder has three files. 
#Goes through the directory and creates a vector of the file names I want to use 
filenames = dir(pattern="*pusum*", ignore.case=TRUE, recursive = TRUE, include.dirs=TRUE, full.names = TRUE)


l = list()
for (f in filenames){
  # Get year, assuming it's the only number the filename
  file_name <- basename(f)
  file_year <- as.numeric(gsub("[^0-9]", "", file_name))
  file_century <- if(file_year > 90) 1900 else 2000
  year <- file_year + file_century
  
  # Load CSV, add year
  temp <- read.csv(f, stringsAsFactors=FALSE)
  temp$year <- year
  
  # Only use frame if it has all the columns we need.
  if(all(data_columns %in% names(temp))) {
    l[[f]] <- data.table(temp[, c(data_columns, "year")])
  }
}

df <- rbindlist(l)

#Add columns
df$regborvisits <- df$VISITS / df$REGBOR

#change state abbreviations to lower case, spelled out states
df$region_name = tolower(region_name[match(df$STABR, region_abbr)])

#Drop territories not supported by Choroplethr
df <- subset(df, !is.na(df$region_name))

#Choroplethr expects a column named 'region' for the state and a column named 'value' for the values to be represented
df <- rename(df, c("region_name"="region", "regborvisits"="value"))

#Reshape for choroplethr
new2006 <- df[which(df$year==2006)]
years <- unique(df$year)

#renaming value columns as years
#did these steps manually for 2006-2013. There has to be a better way.
names(new2006)[names(new2006)=="value"] <- "2006"
#removes extraneous info
new2006 <- select(new2006, one_of(c("region","2006")))

#Make a dataframe that combines all of the years and regions

df1 <- join_all(list(new2006, new2007, new2008, new2009, new2010, new2011, new2012, new2013), by = 'region', type='full')


#DC and North Dakota didn't submit any data, so that's throwing the map off. 
#Cleaned up in Excel, which helpfully put x's in front of some column names. For funsies. 
names(df1)[names(df1)=="X2013"] <- "2013"


#Saving the data frame for later use
write.csv(df1, file="all_data.csv")


save(df1,file="all_data.rdata")

