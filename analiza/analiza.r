# 4. faza: Analiza podatkov

PodatkiRazvrscanje <- PISA %>% group_by(LOCATION, SUBJECT) %>% summarise(POVPRECJE=mean(Value))%>% dcast(LOCATION ~ SUBJECT) %>% 
                          merge(BDPpc %>% group_by(LOCATION) %>% summarise(PovBDPpc=mean(BDPpc, na.rm=TRUE))) %>%
                          merge(ObveznoSol %>% group_by(LOCATION) %>% summarise(PovpObveznaLeta=mean(ObveznaLeta, na.rm=TRUE))) %>% 
                          merge(RazmerjeOS %>% group_by(LOCATION) %>% summarise(PovpRazmerjeOS=mean(RazmerjeOS, na.rm=TRUE))) %>% 
                          merge(RazmerjeSS %>% group_by(LOCATION) %>% summarise(PovpRazmerjeSS=mean(RazmerjeSS, na.rm=TRUE))) %>%
                          merge(ZaIzob %>% group_by(LOCATION) %>% summarise(PovpZaIzob=mean(PotrosnjaZaIzob, na.rm=TRUE))) %>%
                          merge(ZaOsebje %>% group_by(LOCATION) %>% summarise(PovpZaOseb=mean(PotrosnjaZaOsebje, na.rm=TRUE)))

Model <- hclust(dist(scale(PodatkiRazvrscanje)))
  

# Število skupin
# n <- 5
# skupine <- hclust(dist(scale(podatki))) %>% cutree(n)
