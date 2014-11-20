web=read.csv("webometrics.csv")
dat=head (web, 7)

countries=as.character(dat[, 1])
totals=dat[, 8]
dat=dat[,-c (1, 8)]

perc=100*dat/totals
rownames (perc)=countries
head (countries, 7)
matplot (t (perc), type = "b", lty=1, lwd=2)
## CH doesn't have 103 universities!
## data not reliable


dat=read.csv("qsrankings14.csv")
x=1:sum (!is.na(dat[, 1]))
y=dat[x, 1]
fit1=lm(log (y)~x)

xx=1:nrow (dat)

plot (xx, dat[, 1], ylim=c (0, 100), type="l", lwd=5)
preds <- exp(predict(fit1,data.frame(x=xx)))
lines (xx[-x], (preds+2)[-x], lwd=5, col="red")

## dirty extrapolation
dat[xx[-x],1]=(preds+2)[-x]

## countries with most universities in the ranking
countries=rev (names (tail (sort (table (dat[, 3])))))

library (dplyr)
dat %>% filter(Country==countries[1]) %>% select (Score)

## use wikipedia to check how many universities countries have
## http://en.wikipedia.org/wiki/Lists_of_universities_and_colleges_by_country
