# Analiza podatkov s programom R, 2018/19

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2018/19

* [![Shiny](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/TomasRode/APPR-2018-19/master?urlpath=shiny/APPR-2018-19/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/TomasRode/APPR-2018-19/master?urlpath=rstudio) RStudio

## Analiza izobraževanja v državah OECD

Analiziral bom podatke o izobraževanju za države OECD. Za merilo uspešnosti izobraževanja bom, ker gre za države z visoko stopnjo pismenosti, uporabil rezultate testov PISA, ki merijo usprešnost 15-letnikov na treh področjih -- matematika, znanost in branje. Primerjal bom uspešnost držav na teh testih glede na: BDP PPP, število let obveznega šolanja, razmerje med številoma učencev in učiteljev (za osnovne in srednje šole), državno porabo za izobraževanje v % BDP, sredstva namenjena osebju v izobraževanju v % potrošnje v javnih ustanovah.

Da bom lahko opazoval povezave med temi spremenljivkami, bom podatke uredil v sledeče tabele. 

Tabele:
* tabela 1: država, leto, spol, PISAMATH
* tabela 2: država, leto, spol, PISAREADING
* tabela 3: država, leto, spol, PISASCIENCE
* tabela 4: država, leto, BDP PPP
* tabela 5: država, leto, število let obveznega šolanja
* tabela 6: država, leto, razmerje med številoma učencev in učiteljev za osnovne šole, razmerje za srednje šole
* tabela 7: država, leto, državna poraba za izobraževanje v % BDP
* tabela 8: država, leto, sredstva namenjena osebju v izobraževanju v % potrošnje v javnih ustanovah

Podatki v tabelah 4--8 bodo obsegali obdobje med letoma 2000 in 2015, podatki v prvih treh pa bodo dani za leta, ko so bile opravljene meritve, torej v letih 2003, 2006, 2009, 20012, 2015

vira: 
* http://databank.worldbank.org/data/reports.aspx?source=2&Topic=4#advancedDownloadOptions
* https://data.oecd.org/pisa/science-performance-pisa.htm#indicator-chart

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `mosaic` - za pretvorbo zemljevidov v obliko za risanje z `ggplot2`
* `maptools` - za delo z zemljevidi
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

## Binder

Zgornje [povezave](#analiza-podatkov-s-programom-r-201819)
omogočajo poganjanje projekta na spletu z orodjem [Binder](https://mybinder.org/).
V ta namen je bila pripravljena slika za [Docker](https://www.docker.com/),
ki vsebuje večino paketov, ki jih boste potrebovali za svoj projekt.

Če se izkaže, da katerega od paketov, ki ji potrebujete, ni v sliki,
lahko za sprotno namestitev poskrbite tako,
da jih v datoteki [`install.R`](install.R) namestite z ukazom `install.packages`.
Te datoteke (ali ukaza `install.packages`) **ne vključujte** v svoj program -
gre samo za navodilo za Binder, katere pakete naj namesti pred poganjanjem vašega projekta.

Tako nameščanje paketov se bo izvedlo pred vsakim poganjanjem v Binderju.
Če se izkaže, da je to preveč zamudno,
lahko pripravite [lastno sliko](https://github.com/jaanos/APPR-docker) z želenimi paketi.

Če želite v Binderju delati z git,
v datoteki `gitconfig` nastavite svoje ime in priimek ter e-poštni naslov
(odkomentirajte vzorec in zamenjajte s svojimi podatki) -
ob naslednjem.zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
