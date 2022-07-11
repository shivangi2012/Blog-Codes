library(utils) 

#Notes:

#1.dir() in the console to list the files in your working directory. 

#2.utils package is by default loaded in R. All these functions are part of utils package:read.csv(), read.delim(), read.table()

#3. read.table() is the main function. read.csv() & read.delim() are the wrapper functions with sep="," & sep="\t"

#1. load csv file

setwd("D:/R Scripts/")

#path <- file.path("data", "hotdogs.txt")

data<-read.csv("Importing/admins.csv",stringsAsFactors = FALSE)

#to see type of all variables
str(data)

#2. load text file

#if values are separated by tab
data<- read.delim("states.txt", stringsAsFactors = FALSE ,header=FALSE)


#read.table- to read any tabular file as a dataframe. By default, it sets the sep argument to "\t"

#if values are separated by /
data<- read.table("Importing/hotdogs.txt", sep = "\t", col.names = c("type", "calories", "sodium")) 
summary(data) #print out some summary statistics about all variables in the data frame.

# Select the hot dog with the least calories: lily
lily <- data[which.min(data$calories), ]

# Select the observation with the most sodium: tom
tom <- hotdogs[which.max(hotdogs$sodium), ]

#Column classes- specify class of each variable. NUll means it wouldn't load that column
# Edit the colClasses argument to import the data correctly: hotdogs2
hotdogs2 <- read.delim("Importing/hotdogs.txt", header = FALSE, 
                       col.names = c("type", "calories", "sodium"),
                       colClasses = c("factor","NULL","numeric"))


#if file is separated by ; and in number values like this 7,893
read.csv2("hotdogs.txt")

#if file is separated by tab and in number values like this 7,893
read.delim2("hotdogs.txt")

# 3. Load excel file

#readxl package(can load both xls or xlsx package)

library(readxl)
sheets<-excel_sheets("Importing/pedia.xlsx") #list all the sheets
data<-read_excel("Importing/pedia.xlsx",sheet=1)

# Read all Excel sheets with lapply(): pop_list. #read_excel() function is called multiple times on the "data.xlsx" file 
#and each sheet is loaded in one after the other. The result is a list of data frames

pop_list<-lapply(excel_sheets("Importing/pedia.xlsx"),
                 read_excel,
                 path = "Importing/pedia.xlsx", n_max=10)

#R will assign column name
pop_a<-read_excel("urbanpop_nonames.xlsx", sheet=1, col_names=FALSE)

#assign column names. skip first 20 rows
pop_b<-read_excel("urbanpop_nonames.xlsx", sheet=1, col_names=c("country", paste0("year_", 1960:1966)), skip=20, n_max=10)






















