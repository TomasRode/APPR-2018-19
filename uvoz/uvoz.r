# 2. faza: Uvoz podatkov
library(gsubfn)
library(dplyr)
library(data.table)

# sl <- locale("sl", decimal_mark=",", grouping_mark=".")

# Funkcija, ki uvozi podatke iz datoteke druzine.csv

#uvoz .csv datotek -- quote in stringsAsFactors, da nam zazna različne stolpce
PISAmat <- read.csv("PISA_math.csv",quote = "",stringsAsFactors = F) %>% apply(2,function(x){gsubfn('"',"",x)})
PISArea <- read.csv("PISA_reading.csv",quote = "",stringsAsFactors = F) %>% apply(2,function(x){gsubfn('"',"",x)})
PISAsci <- read.csv("PISA_science.csv",quote = "",stringsAsFactors = F) %>% apply(2,function(x){gsubfn('"',"",x)})
WBD <- read.csv("WBD_izobrazevanje.csv", quote = "\"", stringsAsFactors = F, na.strings = "..", 
                col.names = c('meritev','koda meritve', 'ime drzave', 'drzava', 2000:2017)) %>% as.data.frame() %>% 
       apply(2,function(x){gsubfn('"',"",x)}) 
#WBD <- melt(WBD, measure.vars = 2000:2017, variable.name = 'leto')

# Zapišimo podatke v razpredelnico obcine


# Zapišimo podatke v razpredelnico druzine.

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.