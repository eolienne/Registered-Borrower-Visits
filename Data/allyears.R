#Already downloaded all zip files for csv from this site: http://imls.gov/research-evaluation/data-collection/public-libraries-united-states-survey/public-libraries-united 

update.packages()
if("shiny" %in% rownames(installed.packages()) == FALSE) {install.packages("shiny", dependencies = TRUE)}
if("choroplethr" %in% rownames(installed.packages()) == FALSE) {install.packages("choroplethr", dependencies = TRUE)}
if("choroplethrMaps" %in% rownames(installed.packages()) == FALSE) {install.packages("choroplethrMaps", dependencies = TRUE)}
if("data.table" %in% rownames(installed.packages()) == FALSE) {install.packages("data.table", dependencies = TRUE)}

#Trying a script to go through all of the years of PLS files
#Compute per regbor visits then append it to end of data frame with column name of year

library(choroplethr)
library(data.table)
library(choroplethrMaps)
update.packages()


setwd("C:/Users/Alyssa/Box Sync/Programming Projects/IMLSdata/Registered-Borrower-Visits/Data")

#Each year is currently stored in its own folder. Each folder has three files. 
#Goes through the directory and creates a vector of the file names I want to use 
filenames = dir(pattern="*pusum*", ignore.case=TRUE, recursive = TRUE, include.dirs=TRUE, full.names = TRUE)

l = list()
#Go through each file 
i <- 0 
for (i in 1:length(filenames)){
  temp <- read.csv(filenames[i])
  i <- i + 1
  #Look to see if there is even a Registered Borrower (REGBOR) variable in the dataset
  if("REGBOR" %in% colnames(temp))
  {
    print(filenames[i])
    
    #Create a new column that does Visits per Registered Borrower    
    temp$regborvisits <- 0
    temp$regborvisits <- temp$VISITS / temp$REGBOR
    
    #change state abbreviations to lower case, spelled out states
    
    temp$STABR <- tolower(state.name[match(temp$STABR,state.abb)])
    
    #Choroplethr is expecting Washington, DC so I make sure that is included
    temp$STABR[8] <- "district of columbia"
    
    #Removing all of the remaining US territories from the data frame, since choroplethr doesn't accept them. Storing the result as a new dataframe.
    temp <- na.omit(temp)
    
    #Creating data frames that subset STABR and regborvisits
    temp=temp[,c("STABR","regborvisits")]
    l[[filenames[i]]] = temp
    
  } 
}

df = data.frame(region=l[[1]]$STABR)
#df$region = l[[1]]$STABR
#Why isn't 2006 working?
df$'2007' = l[[1]]$regborvisits
df$'2008' = l[[2]]$regborvisits
df$'2009' = l[[3]]$regborvisits
df$'2010' = l[[4]]$regborvisits
df$'2011' = l[[5]]$regborvisits
df$'2012' = l[[6]]$regborvisits
df$'2013' = l[[7]]$regborvisits

df_all_data=df

save(df_all_data,file="all_data.rdata")
rm(df_all_data)

load("all_data.rdata")