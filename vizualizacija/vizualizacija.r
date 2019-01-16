# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(rgdal)
library(rgeos)
source('uvoz/uvoz.r')

PISA.povprecje <- PISA %>% filter(SUBJECT=='TOT') %>% group_by(TIME, LOCATION) %>% summarise(POVPRECJE=mean(Value))

#NE DOBIMO NIC POSEBNEGA, MEDCASOVNA PRIMERJAVA NI SMISELNA, KER JE TESTE TEZKO SESTAVITI VSAKO LETO ENAKE
#ZATO LAHKO DELAMO SAMO PRIMERJAVE MED DRZAVAMI

PISA.2015 <- PISA %>% filter(SUBJECT=='TOT' & TIME==2015) %>% group_by(LOCATION) %>% summarise(POVPRECJE=mean(Value))
PISA2015 <- ggplot(PISA.2015, aes(x= reorder(LOCATION, POVPRECJE),y=POVPRECJE)) + geom_col() + 
                  ggtitle("Povprečje treh indeksov PISA v letu 2015 po državah") + xlab("Države") + ylab("Povprečje")


PISA.BDPPC <- PISA %>% filter(SUBJECT=='TOT') %>% merge(BDPpc)
PISAbdppc <- ggplot(PISA.BDPPC, aes(x=BDPpc,y=Value, color=LOCATION)) + geom_point()
Kpisabdppc <- stats::cor(PISA.BDPPC$BDPpc, PISA.BDPPC$Value)

PISA.ZAIZ <- PISA %>% filter(SUBJECT=='TOT') %>% merge(ZaIzob) %>% filter(is.na(PotrosnjaZaIzob) == FALSE)
PISAzaiz <- ggplot(PISA.ZAIZ, aes(x=PotrosnjaZaIzob,y=Value, color=LOCATION)) + geom_point()
Kpisazaiz <- stats::cor(PISA.ZAIZ$PotrosnjaZaIzob,PISA.ZAIZ$Value)

PISA.RAZO <- PISA %>% filter(SUBJECT=='TOT') %>% merge(RazmerjeOS) %>% filter(is.na(RazmerjeUUOS) == FALSE)
PISArazo <- ggplot(PISA.RAZO, aes(x=RazmerjeUUOS,y=Value, color=LOCATION)) + geom_point()
Kpisarazo <- stats::cor(PISA.RAZO$RazmerjeUUOS,PISA.RAZO$Value)

PISA.RAZS <- PISA %>% filter(SUBJECT=='TOT') %>% merge(RazmerjeSS) %>% filter(is.na(RazmerjeUUSS) == FALSE)
PISArazs <- ggplot(PISA.RAZS, aes(x=RazmerjeUUSS,y=Value, color=LOCATION)) + geom_point()
Kpisarazs <- stats::cor(PISA.RAZS$RazmerjeUUSS,PISA.RAZS$Value)

PISA.ZAOS <- PISA %>% filter(SUBJECT=='TOT') %>% merge(ZaOsebje) %>% filter(is.na(PotrosnjaZaOsebje) == FALSE)
PISAzaos <- ggplot(PISA.ZAOS, aes(x=PotrosnjaZaOsebje,y=Value, color=LOCATION)) + geom_point()
Kpisazaos <- stats::cor(PISA.ZAOS$PotrosnjaZaOsebje,PISA.ZAOS$Value)

PISA.OBV <- PISA %>% filter(SUBJECT=='TOT') %>% merge(ObveznoSol) %>% filter(is.na(ObveznaLeta) == FALSE)
PISAobv <- ggplot(PISA.OBV, aes(x=ObveznaLeta,y=Value, color=LOCATION)) + geom_point()
Kpisaobv <- stats::cor(PISA.OBV$ObveznaLeta, PISA.OBV$Value)




# Uvozimo zemljevid.
source('lib/uvozi.zemljevid.r')

zemljevid <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/110m_cultural.zip",
                             "ne_110m_admin_0_countries", encoding="Windows-1250") %>% fortify

Pzem <- left_join(zemljevid, PISA.povprecje, by = c('ADM0_A3_US'='LOCATION'))
drzaveZ <- sort(unique(zemljevid$ADM0_A3_US))
razlike <- unique(PISA.povprecje$LOCATION)[!(unique(PISA.povprecje$LOCATION)%in%unique(Pzem$ADM0_A3_US))]
# težava: zemljevid nima vnešenih sledečih držav: HONG-KONG, SINGAPUR, MACAO
ggplot() + geom_polygon(data=Pzem, aes(x=long,y=lat,group=group, fill=POVPRECJE ))


