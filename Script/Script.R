# load the library tidyverse
library(tidyverse)
# load the library excel
library(readxl)
#load library cowplot
library(cowplot)
#assign variable to datasets
Favimat <- read_excel("Data/RAFT favimat 19.11.30.xlsx")
Density <- read_excel("Data/White fibre density 19.11.30.xlsx")
FibreID <- read_excel("Data/White fibre ID worksheet19.12.02.xlsx")
Favimat_master_summary19.12.05 <- read_excel("Data/White Fibre Master Summary19.12.05.xlsx")

#make sure that you include any spaces in the column headings in select function and also include backticks if there is space b/w names
#select columns in Density spreadsheet
#Density_selected <- select(Density,'White Fibre Trial Number', 'PAN name (if known)','Density Result Mean')
#rename columns in density dataset to have common info for both spreadsheet so that you can do a inner join. Make sure that when renaming the name you want to give to the column should appear first
Favimat <- rename(Favimat, 'Code' = 'CSIRO Ident')
Density <- rename(Density, 'Code' = 'White Fibre Trial Number')
Favimat_master_summary19.12.05 <- rename(Favimat_master_summary19.12.05, 'Code' = 'CSIRO Ident')
# full join - depends on which dataset you use first and second. From fiddling around it seems like you can use only two datasets to combine at one time , so the action had to be repeated
Combined_dataset_full_join_1 <- full_join(Density, Favimat, by = c("Code")) 
Combined_dataset_full_join_2 <- full_join(FibreID, Combined_dataset_full_join_1, by = c("Code")) 
#Combined_dataset_full_join_2 <- full_join(Favimat, Density, FibreID,by = c("Code"))  
#Combined_dataset_left_join <- left_join(FibreID, Density, Favimat, by = c("Code"))
#Combined_dataset_inner_join <- inner_join(FibreID, Density, Favimat, by = c("Code"))
#str(Combined_dataset_full_join_1)
Combined_dataset_with_master_summary19.12.05 <- full_join(Density, Favimat_master_summary19.12.05, by = c("Code")) 
Final_combined_dataset <- full_join(FibreID, Combined_dataset_with_master_summary19.12.05, by = c("Code"))  
str(Combined_dataset_full_join_2)
#glimpse(Combined_dataset)
#str(FibreID)
#Combined_dataset_full_join_long <- Combined_dataset_full_join_2 %>%
#gather(Repeats, Density_measurement, 'Density Result Test 1', 'Density Result Test 2')
#Combined_dataset_full_join_long

#Plotting/Visualisation
# Comparison of 200K RAFT 6h vs 24h reaction
#Filtering data for these
Trial30_vs_34 <- Combined_dataset_full_join_2 %>%
  filter (Code %in% c("W1467", "W1468", "W1469", "W1525", "W1526", "W1528", "W1529"))
#head(Trial30_vs_34)
#Writing your data
write_csv(Trial30_vs_34, "Results/Trial30_vs_34.csv")
# Plotting
#changing characters into numbers
Trial30_vs_34$`Tenacity (cN/dtex)`<- as.numeric(Trial30_vs_34$`Tenacity (cN/dtex)`)
Trial30_vs_34$`Diameter (mm)`<- as.numeric(Trial30_vs_34$`Diameter (mm)`)
Trial30_vs_34$`Density Result Mean`<- as.numeric(Trial30_vs_34$`Density Result Mean`)
Trial30_vs_34$`Reaction time`<- as.numeric(Trial30_vs_34$`Reaction time`)
Trial30_vs_34$`Ini.Mod1 (cN/dtex)`<- as.numeric(Trial30_vs_34$`Ini.Mod1 (cN/dtex)`)
#Trial30_vs_34$`Reaction time`<- as.factor(Trial30_vs_34$`Reaction time`)
#Trial30_vs_34$`Residence time in coagulation bath (s)`<- as.numeric(Trial30_vs_34$`Residence time in coagulation bath (s)`)
Trial30_vs_34$`Residence time in coagulation bath (s)`<- as.factor(Trial30_vs_34$`Residence time in coagulation bath (s)`)
#Trial30_vs_34$`Total Stretch Ratio`<- as.numeric(Trial30_vs_34$`Total Stretch Ratio`)
Trial30_vs_34$`Total Stretch Ratio`<- as.factor(Trial30_vs_34$`Total Stretch Ratio`)
head(Trial30_vs_34)
str(Trial30_vs_34)
Data_plot <- Trial30_vs_34 %>%
  select('Reaction time', 'Ini.Mod1 (cN/dtex)')
Data_plot
Plot1 <- ggplot(data=Data_plot, aes(x = `Reaction time` , y = `Ini.Mod1 (cN/dtex)`)) + 
  geom_point() 
Plot1
Trial30_vs_31<- Combined_dataset_full_join_2 %>%
  filter (Code %in% c("W1467", "W1468", "W1469", "W1471", "W1472", "W1473", "W1474", "W1475", "W1476", "W1477", "W1478"))
Trial30_vs_31
write_csv(Trial30_vs_31, "Results/Trial30_vs_31.csv")
Trial35 <- Combined_dataset_full_join_2 %>%
  filter (Code %in% c("W1532", "W1533", "W1534", "W1535", "W1537", "W1538", "W1539", "W1540", "W1541", "W1542"))
Trial35
write_csv(Trial35, "Results/Trial35.csv")
Trial36 <- Combined_dataset_full_join_2 %>%
  filter (Code %in% c("W1547", "W1546", "W1550"))
Trial36
write_csv(Trial36, "Results/Trial36.csv")
Trial37 <- Combined_dataset_full_join_2 %>%
  filter (Code %in% c("W1551", "W1552", "W1553", "W1554", "W1555"))
Trial37
write_csv(Trial37, "Results/Trial37.csv")
Trial42_and_43 <- Combined_dataset_full_join_2 %>%
  filter (Code %in% c("W1588", "W1589", "W1590", "W1554", "W1555", "W1598", "W1599", "W1600","W1601", "W1602","1603","1604","1605","1606","1607"))
Trial42_and_43
write_csv(Trial42_and_43, "Results/Trial42_and_43.csv") 
Trial39 <- Final_combined_dataset %>%
  filter (Code %in% c("W1563", "W1564", "W1565", "W1566", "W1567", "W1568", "W1569", "W1570","W1571", "W1572"))
Trial39
write_csv(Trial39, "Results/Trial39.csv")

