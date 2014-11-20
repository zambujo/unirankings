web=read.csv("webometrics.csv")
dat=head (web, 7)

countries=as.character(dat[, 1])
totals=dat[, 8]
dat=dat[,-c (1, 8)]
## CH doesn't have 103 universities!
## data is not reliable

# perc=100*dat/totals
# rownames (perc)=countries
# head (countries, 7)
# matplot (t (perc), type = "b", lty=1, lwd=2)

dat=read.csv("qsrankings14.csv")

## dirty extrapolation:
## assume exponential decay of rankings
x=1:sum (!is.na(dat[, 1]))
y=dat[x, 1]
fit=lm (log (y)~x, weights=x^10)

## x-tended x
xx=1:nrow (dat)

preds <- exp (predict (fit, data.frame(x=xx[-x])))
dat[xx[-x],1]=preds

plot (dat[, 1], ylim=c (0, 100), type="l", lwd=5)
abline (v=length (x)+.5, lty=1, col='red')

## countries with most universities in the ranking
countries=names (tail (sort (table (dat[, 3]))))
countries=c (countries, "Switzerland") # add CH

library (dplyr)
dat %>% filter(Country%in%countries %>% select (Score)

## use wikipedia to check how many universities countries have
## http://en.wikipedia.org/wiki/Lists_of_universities_and_colleges_by_country
