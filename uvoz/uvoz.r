# 2. faza: Uvoz podatkov
library(gsubfn)
library(dplyr)
library(data.table)
library(reshape2)
library(readr)

# sl <- locale("sl", decimal_mark=",", grouping_mark=".")

# Funkcija, ki uvozi podatke iz datoteke druzine.csv

#uvoz .csv datotek -- quote in stringsAsFactors, da nam zazna različne stolpce
PISAmat <- read.csv("PISA_math.csv",quote = "",stringsAsFactors = F) %>% apply(2,function(x){gsubfn('"',"",x)})
PISArea <- read.csv("PISA_reading.csv",quote = "",stringsAsFactors = F) %>% apply(2,function(x){gsubfn('"',"",x)})
PISAsci <- read.csv("PISA_science.csv",quote = "",stringsAsFactors = F) %>% apply(2,function(x){gsubfn('"',"",x)})
WBD <- read_csv("podatki/WBD_izobrazevanje.csv", na="..", n_max=258) 
WBD <- melt(id.vars=1:4, variable.name="leto", value.name="vrednost")
WBD <- mutate(leto=parse_number(leto))

#WBD <- melt(WBD, measure.vars = 2000:2017, variable.name = 'leto')

# Zapišimo podatke v razpredelnico obcine


# Zapišimo podatke v razpredelnico druzine.

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.