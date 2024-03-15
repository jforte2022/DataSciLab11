# Install and activate (“library()”) the sqldf package in RStudio. With any new package it is possible to run into installation issues depending on your platform and the versions of software you are running, so monitor your diagnostic messages carefully (2 points: 1 point per task).

# install.packages("sqldf")
library(sqldf)

# Review online documentation for sqldf so that you are familiar with the basic concepts and usage of the package and its commands (1point).
# (a) Make sure the built-in “airquality” dataset is available for use in subsequent commands (hint: print head(airquality)). It would be wise to reveal the first few records of air quality with head() to make sure that air quality is available. This will also show you the names of the columns of the air quality dataframe which you will need to use in SQL commands

head(airquality)

# (b) assign airquality to an object “air”

air <- airquality

# c) what is the data type of air? You must use a simple command to reveal the data type (3 points).

str(air)

# (a) Using sqldf(), run an SQL select command that calculates the average level of ozone across all records. Assign the resulting value into a variable (average_ozone) 

average_ozone <- sqldf("SELECT AVG(Ozone) FROM air")

# print it out in the console (2 points).

average_ozone

# Again using sqldf(), run another SQL command that selects all of the records from air quality where the value of ozone is higher than the average. Note that it is possible to combine steps 4 and 5 into a single SQL command – those who are familiar with SQL syntax and usage should attempt to do so (1 point).

sqldf("SELECT * FROM air WHERE Ozone > (SELECT AVG(air.Ozone) FROM air)")

# (a) Refine step 5 to write the result table into a new R data object called “newAQ.”

newAQ <- sqldf("SELECT * FROM air WHERE Ozone > (SELECT AVG(air.Ozone) FROM air)")

# (b) Then run a command to reveal what type of object newAQ is

str(newAQ)

# (c) another command to show what its dimensions are (i.e., how many rows and columns),

dim(newAQ)

# (d) a head() command to show the first few rows (4 points: one point per task). 

head(newAQ)

# Steps above was done using a SQL way. Now, repeat steps 4, 5 and 6 in an R way, using R commands including str, mean, head, dim, which, and tapply, which is a more “R” like way to do the analysis (7 points (a through g below): one point per each step). 
# Repeat step 4: calculates the average level of ozone across all records. 
# (a) Exclude Missing Values from calculating "Ozone" mean and assign the result to "average_ozone": Hint:use na.rm

average_ozone <- mean(air$Ozone, na.rm = TRUE)

# (b) print the result (average_ozone)

average_ozone

# (c) select rows with bigger values than the average ozone value 
# only keep the rows in which the Ozone values are higher than the average, and write the result table into a new R data object called "newAQ2"

biggerThanMean <- function(ozone){
  if(ozone > average_ozone && is.na(ozone) == FALSE){
    return(TRUE)
  }else{
    return(FALSE)
  }
}

higherOzoneBool <- sapply(air$Ozone, biggerThanMean)

newAQ2 <- air[higherOzoneBool, ]

# (e) reveal what type of object newAQ2 is

str(newAQ2)

# (f) reveal the number of rows, then reveal the number of columns

nrow(newAQ2)
ncol(newAQ2)

# (g) show the first few rows of "newAQ2"

head(newAQ2)
