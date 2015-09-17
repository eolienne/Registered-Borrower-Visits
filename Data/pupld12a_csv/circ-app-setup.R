#Setting up R for Shiny app development

setwd("C:/Users/Alyssa/Box Sync/Programming Projects/Library stats/pupld12a_csv")

#Read in the data and store it as separate data frames

libraries <- read.csv(file="Puout12a.csv")
staffcirc <- read.csv(file="Pupld12a.csv")
states <- read.csv(file="Pusum12a.csv")

#Make sure that the correct R packages are installed on computer
if("Rcpp" %in% rownames(installed.packages()) == FALSE) {install.packages("Rcpp", dependencies = TRUE)}
if("shiny" %in% rownames(installed.packages()) == FALSE) {install.packages("shiny", dependencies = TRUE)}
if("maps" %in% rownames(installed.packages()) == FALSE) {install.packages("maps", dependencies = TRUE)}
if("mapproj" %in% rownames(installed.packages()) == FALSE) {install.packages("mapproj", dependencies = TRUE)}

#Activate those packages for this environment
library(Rcpp)
library(maps)
library(mapproj)
library(shiny)
setwd("C:/Users/Alyssa/Box Sync/Programming Projects/Library stats/pupld12a_csv/circ-app")
source("helpers.R")

#Store the staffcirc dataframe as a .rds object in the Data directory

dir.create("Data")
setwd("C:/Users/Alyssa/Box Sync/Programming Projects/Library stats/pupld12a_csv/circ-app/Data")
save(staffcirc, file="circs.Rds")
load("circs.Rds")
