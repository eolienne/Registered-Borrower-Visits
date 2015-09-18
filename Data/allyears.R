#Already downloaded all zip files for csv from this site: http://imls.gov/research-evaluation/data-collection/public-libraries-united-states-survey/public-libraries-united 

update.packages()
if("shiny" %in% rownames(installed.packages()) == FALSE) {install.packages("shiny", dependencies = TRUE)}
if("choroplethr" %in% rownames(installed.packages()) == FALSE) {install.packages("choroplethr", dependencies = TRUE)}
if("choroplethrMaps" %in% rownames(installed.packages()) == FALSE) {install.packages("choroplethrMaps", dependencies = TRUE)}
if("data.table" %in% rownames(installed.packages()) == FALSE) {install.packages("data.table", dependencies = TRUE)}

#Trying a script to go through all of the years of PLS files
#Compute per regbor visits then append it to end of data frame with column name of year
#Get column name from the file name? 2006 is the first year to include this?

library(choroplethr)
library(data.table)
update.packages()


setwd("C:/Users/Alyssa/Box Sync/Programming Projects/IMLSdata/Registered-Borrower-Visits/Data")

#Each year is currently stored in its own folder. Each folder has three files. 
#Goes through the directory and creates a vector of the file names I want to use 
filenames = dir(pattern="*pusum*", ignore.case=TRUE, recursive = TRUE, include.dirs=TRUE, full.names = TRUE)

#Go through each file 
i <- 0 
for (i in 1:length(filenames)){
  temp <- read.csv(filenames[i])
  i <- i + 1
#Look to see if there is even a Registered Borrower (REGBOR) variable in the dataset
  if("REGBOR" %in% colnames(temp))
  {
    cat("Yes")
#Create a new column that does Visits per Registered Borrower    
    temp$regborvisits <- temp$VISITS / temp$REGBOR
    temp <- as.data.table(temp)
#Save only regborvisits and the correlating state to a new data frame     
    temp1 <- temp[,VISITS/REGBOR, by=STABR]
    } else {
#Don't even bother with the years that didn't track registered borrowers (pre-2006)
    cat("No")
  } 
}