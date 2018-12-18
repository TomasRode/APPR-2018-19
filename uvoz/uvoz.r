# 2. faza: Uvoz podatkov
library(gsubfn)
library(dplyr)
library(data.table)
library(reshape2)
library(readr)

# sl <- locale("sl", decimal_mark=",", grouping_mark=".")

# Funkcija, ki uvozi podatke iz datoteke druzine.csv

#uvoz .csv datotek -- quote in stringsAsFactors, da nam zazna različne stolpce
PISAmat <- read_csv("podatki/PISAmat.csv", locale=locale(decimal_mark="."))
PISArea <- read_csv("podatki/PISArea.csv", locale=locale(decimal_mark="."))
PISAsci <- read_csv("podatki/PISAsci.csv", locale=locale(decimal_mark="."))
WBD <- read_csv("podatki/WBD_izobrazevanje.csv", na="..", skip=1, n_max=258, 
                col_names = c('meritev','koda meritve','ime drzave','drzava', c(2000:2017))) %>%
       melt(id.vars=1:4, variable.name="leto", value.name="vrednost")
PISA <- rbind(PISAmat, PISArea, PISAsci) %>% filter(LOCATION != c("OAVG", 'TWN'))

# Zapišimo podatke v razpredelnico obcine


# Zapišimo podatke v razpredelnico druzine.

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.