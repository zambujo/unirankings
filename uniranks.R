dat=read.csv("qsrankings14.csv")

## dirty extrapolation:
x=1:sum (!is.na(dat[, 1]))
y=dat[x, 1]
## assume exponential decay of rankings
fit=lm (log (y)~x, weights=x^10)
## x-tended x
xx=1:nrow (dat)
preds <- exp (predict (fit, data.frame(x=xx[-x])))
dat[xx[-x],1]=preds
# plot (dat[, 1], ylim=c (0, 100), type="l", lwd=5)
# abline (v=length (x)+.5, lty=1, col='red')

library (dplyr)
dat=mutate (dat, Rank=1:nrow(dat))
## countries with best rankings on average
best= dat %>% 
      group_by (Country) %>% 
      summarise (Mean=round (mean(Rank))) %>% 
      arrange (Mean) %>% 
      head (., 10)

## manual selection of countries
countries=c ("Switzerland", "France", "United States", "Germany")

totals=dat %>% 
  filter(Country%in%countries) %>%
  group_by (Country) %>%
  summarise (Count=n()) %>%
  arrange (desc (Count))
countries=as.character (totals$Country)
bins=seq(.05, 1, .05)
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

library (extrafont)
# loadfonts()

library (wesanderson)
pal=wes.palette(name="Darjeeling", 5)

svg("qs-qqplot.svg", width=5, height=4, family="Ubuntu Light")
par (mar=c (3, 3, .5, .5), mgp=c (1.8, .5, 0), tcl=.2, cex=1.3,
     lwd=2, xaxs="r", yaxs="r", family="Ubuntu Light")
matplot(counts, type='l', lwd=6, lty=1, pch=1, xlab="% of All Listed Universities", ylab="% Listed Universities of a Country", axes=FALSE, col=pal)
x.text=round (c(.8,.85,.7,.55)*nrow(counts))
text (x.text, c (counts[x.text[1],1], counts[x.text[2],2], 
                 counts[x.text[3],3], counts[x.text[4],4]),
      c ("US","FR","DE","CH"), col=pal, pos=1)
axis (2, las=1, lwd=2, col.ticks=rgb(0,0,0), col=rgb(1,1,1,0))
axis (1, at=axTicks(1), labels=100*bins[axTicks(1)], 
      lwd=2, col.ticks=rgb(0,0,0), col=rgb(1,1,1,0))
abline (v=axTicks(1), lty=3, lwd=1, col=rgb(.6,.6,.6,.5))
abline (h=axTicks(2), lty=3, lwd=1, col=rgb(.6,.6,.6,.5))
dev.off()

## use wikipedia to check how many universities each country has
## http://en.wikipedia.org/wiki/Lists_of_universities_and_colleges_by_country
