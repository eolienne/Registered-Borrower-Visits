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

library(choroplethr)
state_choropleth(states)

#making new column
#states["PER_CAP_VISITS"] <- NA
#Populating it with visits per capita data
#states$PER_CAP_VISITS <- states$POPU_UND / states$VISITS
#Explore this data
#states$PER_CAP_VISITs
#states[states$PER_CAP_VISITs > 0.3, ]
#making new column for percent of population as registered users
#annoying: have to keep renaming 'value' to columns to make the state chart work
#also annoying that I have to make a new column for each analysis