setwd("C:/Users/Alyssa/Box Sync/Programming Projects/Library stats/pupld12a_csv/")
df <- read.csv(file="Pusum12a.csv")
save(df, file="df.Rds")
load("df.Rds")

#Cleaning up data to make it compatible with choropleths function
colnames(df)[84] <- "value"
colnames(df)[1] <- "region"
df$region <- tolower(state.name[match(df$region,state.abb)])
df$region[8] <- "district of columbia"
states <- na.omit(df)

library(choroplethr)
state_choropleth(states)

#making new column
states["PER_CAP_VISITS"] <- NA
#Populating it with visits per capita data
states$PER_CAP_VISITS <- states$POPU_UND / states$VISITS
#Explore this data
states$PER_CAP_VISITs
states[states$PER_CAP_VISITs > 0.3, ]
#making new column for percent of population as registered users
#annoying: have to keep renaming 'value' to columns to make the state chart work
#also annoying that I have to make a new column for each analysis