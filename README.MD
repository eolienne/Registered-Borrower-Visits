#Which states have the most visits per registered borrower each year?

This is a R project for exploring annual visits per registered public library borrower by state, as recorded by the Public Libraries in the United States survey (PLS).

[Access to the public use data files can be accessed here](http://imls.gov/research-evaluation/data-collection/public-libraries-united-states-survey/public-libraries-united), in addition to documentation about the collection of the data.  

My vision is to eventually create a Shiny application that will allow users to toggle between years. PLS covers 1992-2013. 

Not every year captures "registered borrower" data. It appears to only be 2006-2013. 

####Currently: 9/17/2015
Need to store newly generated columns in a better way. Current method uses a for loop and thus erases the preceding computation. Maybe lapply could help?
* 9/16/2015 Started to experiment with Shiny then realized that I want my data structure to be more efficient. Currently developing more programmatic (and reproducible) way to extract data and create a more useable dataset.
* 9/15/2015: I have created maps for 2012 and 2011. 
