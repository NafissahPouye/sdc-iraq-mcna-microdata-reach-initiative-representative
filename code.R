#Load required libraries
library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
setwd("C:/Users/LENOVO T46OS/Desktop/sdc-iraq-mcna-microdata-reach-initiative-representative")
data <- read_excel("data.xlsx", sheet = "hh_data_representative")


#Select key variables                   
selectedKeyVars <- c('population_group','district', 'age_respondent',
                     'gender_respondent', 'hhh', 'district_origin',
                     'num_hh_member')

#select weights
weightVars <- c('weights')

#Convert variables into factors
cols =  c('population_group','district', 'age_respondent',
          'gender_respondent', 'hhh', 'district_origin',
          'num_hh_member')

data[,cols] <- lapply(data[,cols], factor)

#Convert the sub file into a dataframe
subVars <- c(selectedKeyVars, weightVars)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)
objSDC <- createSdcObj(dat = fileRes, 
                       keyVars = selectedKeyVars, weightVar = weightVars
                       )

#print the risk
print(objSDC, "risk")
#max(objSDC@risk$global[, "risk"])

#Generate an internal (extensive) report
report(objSDC, filename = "index",internal = T, verbose = TRUE) 


