# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(rgdal)
library(rgeos)
library(mosaic)
library(maptools)
source('uvoz/uvoz.r')

PISA.povprecje <- PISA %>% filter(SUBJECT=='TOT') %>% group_by(TIME, LOCATION) %>% summarise(POVPRECJE=mean(Value))
PISApov <- ggplot(PISA.povprecje, aes(x=TIME,y=POVPRECJE, color=LOCATION)) + geom_line()

#NE DOBIMO NIC POSEBNEGA, MEDCASOVNA PRIMERJAVA NI SMISELNO, KER JE TESTE TEZKO SESTAVITI VSAKO LETO ENAKE
#ZATO LAHKO DELAMO SAMO PRIMERJAVE MED DRZAVAMI

PISA.BDPPC <- PISA %>% filter(SUBJECT=='TOT') %>% merge(BDPpc)
PISAbdppc <- ggplot(PISA.BDPPC, aes(x=BDPpc,y=Value, color=LOCATION)) + geom_point()

PISA.ZASO <- PISA %>% filter(SUBJECT=='TOT') %>% merge(ZaSolstvo)
PISAzaso <- ggplot(PISA.ZASO, aes(x=PotrosnjaZaSolstvo,y=Value, color=LOCATION)) + geom_point()
Kpisazaso <- cor(PISA.ZASO$PotrosnjaZaSolstvo,PISA.ZASO$Value)

PISA.RAZO <- PISA %>% filter(SUBJECT=='TOT') %>% merge(RazmerjeOS)
PISArazo <- ggplot(PISA.RAZO, aes(x=RazmerjeUUOS,y=Value, color=LOCATION)) + geom_point()
Kpisarazo <- cor(PISA.RAZO$RazmerjeUUOS,PISA.RAZO$Value)

PISA.RAZS <- PISA %>% filter(SUBJECT=='TOT') %>% merge(RazmerjeSS)
PISArazs <- ggplot(PISA.RAZS, aes(x=RazmerjeUUSS,y=Value, color=LOCATION)) + geom_point()
Kpisarazs <- cor(PISA.RAZS$RazmerjeUUSS,PISA.RAZS$Value)

PISA.ZAOS <- PISA %>% filter(SUBJECT=='TOT') %>% merge(ZaOsebje)
PISAzaos <- ggplot(PISA.ZAOS, aes(x=PotrosnjaZaOsebje,y=Value, color=LOCATION)) + geom_point()
Kpisazaos <- cor(PISA.ZAOS$PotrosnjaZaOsebje,PISA.RAZS$Value)

PISA.OBV <- PISA %>% filter(SUBJECT=='TOT') %>% merge(ObveznoSol)
PISAobv <- ggplot(PISA.OBV, aes(x=ObveznaLeta,y=Value, color=LOCATION)) + geom_point()
Kpisaobv <- cor(PISA.OBV$ObveznaLeta, PISA.OBV$Value)




# Uvozimo zemljevid.
# zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip", "OB",
#                              pot.zemljevida="OB", encoding="Windows-1250")
# levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
#   { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
# zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels=levels(obcine$obcina))
# zemljevid <- fortify(zemljevid)

# Izračunamo povprečno velikost družine
# povprecja <- druzine %>% group_by(obcina) %>%
#   summarise(povprecje=sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))
