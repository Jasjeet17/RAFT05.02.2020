# load the library tidyverse
library(tidyverse)
# load the library excel
library(readxl)
#load library cowplot
library(cowplot)
#Read all files i.e. sample information and measured properties
SampleID <- read_excel("Data/Sample identification spreadsheets/WSL White Fibre worksheet 05.02.2020.xlsx")
PolymerID <- read_excel("Data/Sample identification spreadsheets/Polymer ID Worksheet 05.02.2020.xlsx")
Density <- read_excel("Data/Properties measured/Master Density Results 05.02.2020.xlsx")
Microscopy <- read_excel("Data/Properties measured/Master Density Results 05.02.2020.xlsx")
Favimat <- read_excel("Data/Properties measured/White Fibre Master Summary 05.02.2020.xlsx")
#Header for the unique code should be same in all spreadsheets to combine them based on this. So to do so we may have to rename it
# combine SampleId and Polymer ID based on polymer code; new name = old name is the format. this didn't wok so I changed the names in the spreadsheet itself
#rename(PolymerID, 'Polymer: ID'='New Polymer ID Codes  (as of August 2019)')
#str(PolymerID)
#str(SampleID)
# full join - depends on which dataset you use first and second. From fiddling around it seems like you can use only two datasets to combine at one time , so the action had to be repeated
#Inner_join1 <- inner_join (SampleID, PolymerID)
#full_join2 <- full_join (PolymerID,SampleID)
#left_join1 <- left_join(SampleID, PolymerID)

#Sample_identification_joined <- full_join (PolymerID,SampleID)

Properties_joined <- full_join (Density, Favimat, by = c("Code"))
SampleID_and_properties_joined <- full_join (SampleID, Properties_joined, by = c("Code"))

#Join sample info with measured popeties
#Final_sheet <- full_join(Sample_identification_joined,Properties_joined1, by = c("Code")) - gave error as size is too big
#Properties_joined2 <- full_join(Properties_joined1, Microscopy, by = c("Code"))
#Sample_identification_joined <- full_join(SampleID, PolymerID, by = c("Polymer_ID")) 
#Combined_dataset_full_join_2 <- full_join(FibreID, Combined_dataset_full_join_1, by = c("Code")) 

#Filtering data 
Trial30_vs_34 <- SampleID_and_properties_joined %>%
filter (Code %in% c("W1467", "W1468", "W1469", "W1525", "W1526", "W1528", "W1529"))
head(Trial30_vs_34)

#Writing your data
write_csv(Trial30_vs_34, "Results/Trial30_vs_34.csv")
#Filtering data to anlayse RAFT trials 
#SampleID_and_properties_joined$`Trial Number`<- as.numeric(SampleID_and_properties_joined$ `Trial Number`)
#str(SampleID_and_properties_joined)
RAFT_trials_150K <- SampleID_and_properties_joined %>%
  filter (Code %in% c("W1608","W1609","W1610", "W1611", "W1612", "W1613", "W1614", "W1615", "W1616", "W1617"))
write_csv(RAFT_trials_150K, "Results/RAFT150K.csv")
#str(SampleID_and_properties_joined)
# Plotting
#changing characters into numbers
Trial30_vs_34$`Tenacity (cN/dtex)`<- as.numeric(Trial30_vs_34$`Tenacity (cN/dtex)`)
Trial30_vs_34$`Diameter (mm)`<- as.numeric(Trial30_vs_34$`Diameter (mm)`)
Trial30_vs_34$`Density Result Mean`<- as.numeric(Trial30_vs_34$`Density Result Mean`)
Trial30_vs_34$`Reaction time`<- as.numeric(Trial30_vs_34$`Reaction time`)
Trial30_vs_34$`Ini.Mod1 (cN/dtex)`<- as.numeric(Trial30_vs_34$`Ini.Mod1 (cN/dtex)`)


RAFT_sample_info<- Sample_identification_joined %>%
  filter (`Trial Number (TN)` %in% c("))
head(Trial30_vs_34)