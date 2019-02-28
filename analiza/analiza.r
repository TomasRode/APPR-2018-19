# 4. faza: Analiza podatkov
require(ggdendro)


PodatkiRazvrscanje <- PISA %>% group_by(LOCATION, SUBJECT) %>% summarise(POVPRECJE=mean(Value))%>% dcast(LOCATION ~ SUBJECT) %>% 
                          merge(BDPpc %>% group_by(LOCATION) %>% summarise(PovBDPpc=mean(BDPpc, na.rm=TRUE))) %>%
                          merge(ObveznoSol %>% group_by(LOCATION) %>% summarise(PovpObveznaLeta=mean(ObveznaLeta, na.rm=TRUE))) %>% 
                          merge(RazmerjeOS %>% group_by(LOCATION) %>% summarise(PovpRazmerjeOS=mean(RazmerjeUUOS, na.rm=TRUE))) %>% 
                          merge(RazmerjeSS %>% group_by(LOCATION) %>% summarise(PovpRazmerjeSS=mean(RazmerjeUUSS, na.rm=TRUE))) %>%
                          merge(ZaIzob %>% group_by(LOCATION) %>% summarise(PovpZaIzob=mean(PotrosnjaZaIzob, na.rm=TRUE))) %>%
                          merge(ZaOsebje %>% group_by(LOCATION) %>% summarise(PovpZaOseb=mean(PotrosnjaZaOsebje, na.rm=TRUE)))

rownames(PodatkiRazvrscanje) <- PodatkiRazvrscanje$LOCATION
PodatkiRazvrscanje <- PodatkiRazvrscanje[-1]

Model <- hclust(dist(scale(PodatkiRazvrscanje)))

ggdendrogram(Model)
  

# Število skupin
NaslikajRazvscanje <- function(n){

skupine <- hclust(dist(scale(PodatkiRazvrscanje))) %>% cutree(n)
tabelaskupin <- data.frame(as.list(skupine))
imena <- names(tabelaskupin)
tabelaskupin <- data.frame(imena, skupine) %>% rename(LOCATION = imena, SKUPINE = skupine)
rownames(tabelaskupin) <- c()
Rzem <- left_join(zemljevid, tabelaskupin, by = c('ADM0_A3_US'='LOCATION'))
Rzemljevid <- ggplot() + geom_polygon(data=Rzem, aes(x=long,y=lat,group=group, fill=factor(SKUPINE)), show.legend = FALSE)

Rzemljevid
}
