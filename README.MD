#Which states have the most visits per registered borrower each year?

This is a R project for exploring annual visits per registered public library borrower by state, as recorded by the Public Libraries in the United States survey (PLS).

[Access to the public use data files can be accessed here](http://imls.gov/research-evaluation/data-collection/public-libraries-united-states-survey/public-libraries-united), in addition to documentation about the collection of the data.  

Compare years using my [Shiny Application](https://alyssahislop.shinyapps.io/Registered-Borrower-Visits)

Not every year captures "registered borrower" data. It appears to only be 2006-2013. 

Washington DC had no data for registered borrowers in 2006 and 2007. North Dakota did not have data for 2006.

###[Here's my .rdata file from this project](https://github.com/eolienne/Registered-Borrower-Visits/blob/master/Data/all_data.rdata)


####Currently: 11/9/2015
Major revisions to how the data was pulled and calculated into a data frame to use in the Shiny app. Need to refine the janky clean-up job I did to shove this data into Shiny + Choroplethr. Want to create a data overview of the completeness of the IMLS dataset. 
* 11/9/2015 Finally deployed Shiny app!
* 9/19/2015 Created data frame that has each year of visits per registered borrower. Currently 2006 isn't coming up, although it should. Will look into this later.
* 9/17/2015 Need to store newly generated columns in a better way. Current method uses a for loop and thus erases the preceding computation. Maybe lapply could help?
* 9/16/2015 Started to experiment with Shiny then realized that I want my data structure to be more efficient. Currently developing more programmatic (and reproducible) way to extract data and create a more useable dataset.
* 9/15/2015: I have created maps for 2012 and 2011. 
