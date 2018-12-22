# 2. faza: Uvoz podatkov
library(gsubfn)
library(dplyr)
library(data.table)
library(reshape2)
library(readr)


uvozi.pisa <- function(){
  PISAmat <- read_csv("podatki/PISAmat.csv", locale=locale(decimal_mark="."))
  PISArea <- read_csv("podatki/PISArea.csv", locale=locale(decimal_mark="."))
  PISAsci <- read_csv("podatki/PISAsci.csv", locale=locale(decimal_mark="."))
  PISA <<- rbind(PISAmat, PISArea,PISAsci) %>% filter(LOCATION != 'OAVG' & LOCATION != 'TWN') %>%
    select(-4,-5,-8)
}

uvozi.wbd <- function(){
  WBD <- read_csv("podatki/WBD_izobrazevanje.csv", na="..", skip=1, n_max=258, 
                col_names = c('meritev','koda meritve','ime drzave','LOCATION', c(2000:2017))) %>%
    melt(id.vars=1:4, variable.name="TIME", value.name="vrednost") %>% select(-2) %>%
    filter(TIME != 2015 & TIME != 2016 & TIME != 2017)
  ImenaDrzav <<- select(WBD, 2, 3)
  BDPpc <<- filter(WBD, meritev == 'GDP per capita (constant 2010 US$)') %>% 
    select(-1, -2) %>% rename(BDPpc_ref2010USD = vrednost)
  ZaSolstvo <<- filter(WBD, meritev == "Government expenditure on education, total (% of GDP)") %>% 
    select(-1, -2) %>% rename(PotrosnjaZaSolstvo = vrednost)
  RazmerjeOS <<- filter(WBD, meritev == "Pupil-teacher ratio, primary") %>% 
    select(-1, -2) %>% rename(RazmerjeUUOS = vrednost)
  RazmerjeSS <<- filter(WBD, meritev == "Pupil-teacher ratio, secondary") %>% 
    select(-1, -2) %>% rename(RazmerjeUUSS = vrednost)
  ZaOsebje <<- filter(WBD, meritev == "All education staff compensation, total (% of total expenditure in public institutions)") %>% 
    select(-1, -2) %>% rename(PotrosnjaZaOsebje = vrednost)
  ObveznoSol <<- filter(WBD, meritev == "Compulsory education, duration (years)") %>% 
    select(-1, -2) %>% rename(ObveznaLeta = vrednost)
}

uvozi.pisa()
uvozi.wbd()

