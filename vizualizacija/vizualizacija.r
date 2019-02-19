# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(rgdal)
library(rgeos)
source('uvoz/uvoz.r')

PISA.povprecje <- PISA %>% filter(SUBJECT=='TOT') %>% group_by(LOCATION) %>% summarise(POVPRECJE=mean(Value))


PISA.2015 <- PISA %>% filter(SUBJECT=='TOT' & TIME==2015) %>% group_by(LOCATION) %>% summarise(POVPRECJE=mean(Value))
barve <- ifelse(PISA.2015$LOCATION=='SVN', 'JE', 'NI')
PISA2015 <- ggplot(PISA.2015, aes(x= reorder(LOCATION, POVPRECJE),y=POVPRECJE, fill = barve)) + geom_col(show.legend = FALSE) + 
                  ggtitle("Povprečje treh indeksov PISA v letu 2015 po državah") + 
                  xlab("Države") + ylab("Povprečje") + theme(axis.text.x=element_text(angle=90, hjust=1, vjust=0.5))


PISA.BDPPC <- PISA %>% filter(SUBJECT=='TOT')%>% group_by(LOCATION,TIME) %>% summarise(POVPRECJE=mean(Value)) %>% merge(BDPpc)
PISAbdppc <- ggplot(PISA.BDPPC, aes(x=BDPpc,y=POVPRECJE)) + geom_point() + geom_smooth(method="loess") +
                    ggtitle("Povprečje indeksov PISA po BDP per capita") + 
                    xlab("BDP per capita (v USD)") + ylab("Povprečje indeksov PISA")

Kpisabdppc <- stats::cor(PISA.BDPPC$BDPpc, PISA.BDPPC$POVPRECJE)

PISA.ZAIZ <- PISA %>% filter(SUBJECT=='TOT') %>% group_by(LOCATION,TIME) %>% summarise(POVPRECJE=mean(Value)) %>% merge(ZaIzob) %>% filter(is.na(PotrosnjaZaIzob) == FALSE)
PISAzaiz <- ggplot(PISA.ZAIZ, aes(x=PotrosnjaZaIzob,y=POVPRECJE)) + geom_point() + geom_smooth(method="lm")
Kpisazaiz <- stats::cor(PISA.ZAIZ$PotrosnjaZaIzob,PISA.ZAIZ$POVPRECJE)

PISA.RAZO <- PISA %>% filter(SUBJECT=='TOT') %>% group_by(LOCATION,TIME) %>% summarise(POVPRECJE=mean(Value)) %>% merge(RazmerjeOS) %>% filter(is.na(RazmerjeUUOS) == FALSE)
PISArazo <- ggplot(PISA.RAZO, aes(x=RazmerjeUUOS,y=POVPRECJE)) + geom_point() + geom_smooth(method="lm")
Kpisarazo <- stats::cor(PISA.RAZO$RazmerjeUUOS,PISA.RAZO$POVPRECJE)

PISA.RAZS <- PISA %>% filter(SUBJECT=='TOT') %>% group_by(LOCATION,TIME) %>% summarise(POVPRECJE=mean(Value)) %>% merge(RazmerjeSS) %>% filter(is.na(RazmerjeUUSS) == FALSE)
PISArazs <- ggplot(PISA.RAZS, aes(x=RazmerjeUUSS,y=POVPRECJE)) + geom_point() + geom_smooth(method="lm")
Kpisarazs <- stats::cor(PISA.RAZS$RazmerjeUUSS,PISA.RAZS$POVPRECJE)

PISA.ZAOS <- PISA %>% filter(SUBJECT=='TOT', LOCATION!='EST') %>% group_by(LOCATION,TIME) %>% summarise(POVPRECJE=mean(Value)) %>% merge(ZaOsebje) %>% filter(is.na(PotrosnjaZaOsebje) == FALSE)
PISAzaos <- ggplot(PISA.ZAOS, aes(x=PotrosnjaZaOsebje,y=POVPRECJE)) + geom_point() + geom_smooth(method="lm")
Kpisazaos <- stats::cor(PISA.ZAOS$PotrosnjaZaOsebje,PISA.ZAOS$POVPRECJE)

PISA.OBV <- PISA %>% filter(SUBJECT=='TOT') %>% group_by(LOCATION,TIME) %>% summarise(POVPRECJE=mean(Value)) %>% merge(ObveznoSol) %>% filter(is.na(ObveznaLeta) == FALSE)
PISAobv <- ggplot(PISA.OBV, aes(x=ObveznaLeta,y=POVPRECJE)) + geom_col()
Kpisaobv <- stats::cor(PISA.OBV$ObveznaLeta, PISA.OBV$POVPRECJE)

##RAZLIKA MED SPOLOMA

PISA.SPOL <- PISA %>% filter(SUBJECT != 'TOT') %>% group_by(LOCATION,TIME, SUBJECT) %>% summarise(POVPRECJE=mean(Value))

PISAspol <- ggplot(PISA.SPOL, aes(x=BDPpc,y=POVPRECJE)) + geom_point()


PISA.RAZLIKA <- PISA.SPOL %>% dcast(LOCATION + TIME ~ SUBJECT) %>% transmute(LOCATION, TIME, RAZLIKA=GIRL-BOY) %>% group_by(LOCATION) %>% summarise(PRAZ = mean(RAZLIKA))
PISArazlika <- ggplot(PISA.RAZLIKA, aes(x= reorder(LOCATION, PRAZ),y=PRAZ)) + geom_col() + 
                      ggtitle("Povprečna razlika med rezultati dečkov in deklet po državah") + 
                      xlab("Države") + ylab("Povprečna razlika (v številu šresežnih točk pri dekletih)") + theme(axis.text.x=element_text(angle=90, hjust=1, vjust=0.5))

PISA.spol.bdp <- PISA.SPOL %>% dcast(LOCATION + TIME ~ SUBJECT) %>% transmute(LOCATION, TIME, RAZLIKA=BOY-GIRL) %>% merge(BDPpc)
Kpisaspolbdp <- stats::cor(PISA.spol.bdp$RAZLIKA, PISA.spol.bdp$BDPpc)

# Uvozimo zemljevid.
source('lib/uvozi.zemljevid.r')

zemljevid <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/110m_cultural.zip",
                             "ne_110m_admin_0_countries", encoding="UTF-8") %>% fortify

Pzem <- left_join(zemljevid, PISA.povprecje, by = c('ADM0_A3_US'='LOCATION'))
drzaveZ <- sort(unique(zemljevid$ADM0_A3_US))
razlike <- unique(PISA.povprecje$LOCATION)[!(unique(PISA.povprecje$LOCATION)%in%unique(Pzem$ADM0_A3_US))]
# težava: zemljevid nima vnešenih sledečih držav: HONG-KONG, SINGAPUR, MACAO
Pzemljevid <- ggplot() + geom_polygon(data=Pzem, aes(x=long,y=lat,group=group, fill=POVPRECJE ))


