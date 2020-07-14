## manual selection of countries

# countries=c ("Switzerland", "France", "United States", "Germany")
countries=c ("CH", "FR", "US", "DE")

totals=dat %>% 
  filter(Country%in%countries) %>%
  group_by (Country) %>%
  summarise (Count=n()) %>%
  arrange (desc (Count))
countries=as.character (totals$Country)
bins=seq(.01, 1, .01)
breaks=round (bins*nrow(dat))
counts=matrix (0, length (breaks), nrow (totals))
colnames (counts)=countries
Quantile=paste (100*bins, "%", sep='')
rownames (counts)=Quantile

for (k in 1:length (breaks)) {
  part=dat[1:breaks[k],] %>% 
    filter(Country%in%countries) %>%
    group_by (Country) %>%
    summarise (Count=n())
  icountries=as.character (part$Country)
  imatch=match (icountries, countries)
  counts[k, imatch]=round (100*part$Count/totals$Count[imatch])
}


library ('extrafont')
loadfonts()

snsfscheme = c ("#0054A2", "#EE7100", "#6F6F6F", "#1A1A18", "#7093CB", "#F7AE6F", "#BAC7E6", "#1461AB", "#F08124", "#808080", "#3B3B3A", "#819ED1", "#F8B77F", "#C1CCE9")
pal = head (snsfscheme, ncol(counts))


## QQ plot
svg("qs-qqplot.svg", width=5, height=4, family="Ubuntu Light")
par (mar=c (3, 3, .5, .5), mgp=c (1.8, .2, 0), tcl=.2, cex=1.3,
     lwd=2, xaxs="r", yaxs="r", family="Lato")
matplot(counts, type='l', lwd=4, lty=1, pch=1, xlab="% of All Listed Universities", ylab="% Listed Universities of a Country", axes=FALSE, col=pal)
axis (2, las=1, lwd=0, col.ticks=rgb(0,0,0), col=rgb(1,1,1,0))
axis (1, lwd=0, col.ticks=rgb(0,0,0), col=rgb(1,1,1,0))
abline (v=axTicks(1), lty=2, lwd=1, col=rgb(.6,.6,.6,.5))
abline (h=axTicks(2), lty=2, lwd=1, col=rgb(.6,.6,.6,.5))
legend ("bottomright", countries, fill = pal, 
        horiz = F, bg=NA, box.col = NA, cex = .8)
dev.off()


## plot with absolute frequencies for x
country_selection = c ("CH", "US","DE", "FR") 
rownames(counts) = breaks
counts = counts[, country_selection]
pal = head (snsfscheme, ncol(counts))
x_ = round (bins*100)

svg("ch_all-plot.svg", width=6, height=4, family="Ubuntu Light")
par (mar=c (3, 3, .5, .5), mgp=c (1.8, .2, 0), tcl=.2, cex=1.3,
     lwd=2, xaxs="r", yaxs="r", family="Lato")
CH_lo <- loess(counts[, "CH"]~x_)
FR_lo <- loess(counts[, "FR"]~x_)
US_lo <- loess(counts[, "US"]~x_)
DE_lo <- loess(counts[, "DE"]~x_)
matplot(counts, type='l', lwd=5, lty=1, pch=1, 
        xlab=paste0 ("Top ", nrow(dat)," Universities"),
        ylab=paste0 ("% Country-Listed Unis in Top ", nrow(dat)),
        axes=FALSE, col=pal)
axis (2, las=1, lwd=0, col.ticks=rgb(0,0,0), col=rgb(1,1,1,0))
axis (1, lwd=0, at=axTicks(1), labels=c ("0",rownames(counts))[1+axTicks(1)], col.ticks=rgb(0,0,0), col=rgb(1,1,1,0))
abline (v=axTicks(1), lty=2, lwd=1, col=rgb(.6,.6,.6,.5))
abline (h=axTicks(2), lty=2, lwd=1, col=rgb(.6,.6,.6,.5))
lines(predict (CH_lo), col = pal[1], lty = 3)
lines(predict (US_lo), col = pal[2], lty = 3)
lines(predict (DE_lo), col = pal[3], lty = 3)
lines(predict (FR_lo), col = pal[4], lty = 3)
legend ("bottomright", c (paste0("Switzerland", " (",sum (dat$Country=="CH"), ")"),
                          paste0("United States", " (",sum (dat$Country=="US"), ")"),
                          paste0("Germany", " (",sum (dat$Country=="DE"), ")"),
                          paste0("France", " (",sum (dat$Country=="FR"), ")")), fill = pal, 
        horiz = F, bg=NA, box.col = NA, cex = 1, inset = .05)
dev.off()


## 60% of Swiss Universities are listed in the top 200 Universities

## use wikipedia to check how many universities each country has
## http://en.wikipedia.org/wiki/Lists_of_universities_and_colleges_by_country
