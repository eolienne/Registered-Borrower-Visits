#Already downloaded all zip files for csv from this site: http://imls.gov/research-evaluation/data-collection/public-libraries-united-states-survey/public-libraries-united 


#Trying a script to go through all of the years of PLS files
#Compute per regbor visits then append it to end of data frame with column name of year
#Get column name from the file name? 92, 93, 94, etc.

library(choroplethr)
library(data.table)

setwd("C:/Users/Alyssa/Box Sync/Programming Projects/IMLSdata/Data")

#Each year is currently stored in its own folder. Each folder has three files. 
filenames = dir(pattern="*pusum*", ignore.case=TRUE, recursive = TRUE, include.dirs=TRUE)
allyears <- data.table(keep.rownames = TRUE)

for (i in 1:length(filenames))
{
  #read all each file
  tmp <- read.csv(filenames[i])
  
  #calculating the per registered borrower annual visits
  tmp$regborvisits <- tmp$VISITS / tmp$REGBOR
  
  #add that column to the dataframe that covers all years. The new column name should be the date?
  allyears[i] <- tmp

}

