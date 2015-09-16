#Which states have the most visits per registered borrower each year?

This is a R project for exploring annual visits per registered public library borrower by state, as recorded by the Public Libraries in the United States survey (PLS).

[Access to the public use data files can be accessed here](http://imls.gov/research-evaluation/data-collection/public-libraries-united-states-survey/public-libraries-united), in addition to documentation about the collection of the data.  

My vision is to eventually create a Shiny application that will allow users to toggle between years. PLS covers 1992-2013. 

##Currently: 9/15/2015
I have created maps for 2012 and 2011. 

####Lingering questions, 9/15/2015
*Should I just add the per registered borrower calculation from each year to a data frame that only has those numbers for each year, plus the state abbreviation? Maybe subset them into a data.table?
**If yes, then how does this work with choroplethr, given that it's expecting "region" and "values" for only two columns. 
*Can shiny toggle between different data frames?

