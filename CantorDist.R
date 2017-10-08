### Cantor distribution functions for R
###    by Henry Bottomley January 2016 updated October 2017

# quantile using Cantor transformation
# with an idea from nicola's http://stackoverflow.com/a/26167613/672221
qCantor <- function(p, lower.tail = TRUE, log.p = FALSE, bits=32){
    if(log.p){        p <- exp(p) }
    if(! lower.tail){ p <- 1 - p  }
    q <- ifelse( p > 1, NaN, ifelse( p == 1, 1, ifelse( p == 0, 0,  ifelse( p < 0, NaN, 
          (floor((as.matrix(p-2^-bits) %*% 2^(1:bits) ) %% 2) * 2 ) %*% 3^(-1:-bits) +3^-bits ))))
    q
    }

# random values using Cantor transformation
rCantor <- function(n, bits=32){
    qCantor(runif(n), bits=bits) 
    }

# cumulative distribution by reversing Cantor transformation
pCantor <- function(q, lower.tail = TRUE, log.p = FALSE, bits=32){
    first1already <- logical(length(q))
    p <- numeric(length(q))
    qtest <- numeric(length(q))
    for (b in 1:bits) { 
        low1  <-  (qtest +   3^(-b) < q)
        low2  <-  (qtest + 2*3^(-b) < q)
        qtest <- qtest + ifelse(low1, 3^(-b), 0) + ifelse(low2, 3^(-b), 0)
        p     <- p + ifelse(low1 & ! first1already, 2^(-b), 0)      
        first1already <- first1already | (low1 & ! low2)
        }
    #p <- p + 2^{-bits}
    p <- ifelse( q >= 1, 1, ifelse( q <= 0, 0, p ))
    if(! lower.tail){ p <- 1-p    }
    if(log.p){        p <- log(p) }
    p
    }

# density or mass not particularly informative - avoid using
#    since distribution is continuous but not absolutely continuous
dCantor <- function(x, log=FALSE, continuous=TRUE, bits=32){
    d <- pCantor(x, bits=bits) - pCantor(x - 2^(-bits), bits=bits)
    if(continuous){ d <- ifelse(d <= 0, 0, Inf)  }
    if(log){        d <- log(d) }
    d
    }

#### Examples
examples <- function() {
qCantor(0.249999999) # 1/4 binary 0.001111... times2 0.002222... tern2dec 1/9
qCantor(0.250000001) # 1/4 binary 0.010000... times2 0.020000... tern2dec 2/9
qCantor(1/4)         # lower quartile between 1/9 and 2/9 
qCantor(1/2)         # median actually between 1/3 and 2/3
pCantor(1/4)         # 1/4 ternary 0.0202... div2 0.0101... bin2dec 1/3
pCantor(1/3)         # median actually between 1/3 and 2/3
pCantor(2/3)         # median actually between 1/3 and 2/3
mean(rCantor(100000))                   # ~ = 1/2
var( rCantor(100000))                   # ~ = 1/8
plot.ecdf(rCantor(10000))               # Devil's staircase      
plot(pCantor, type="p")                 # Devil's staircase points        
plot(qCantor, type="p")                 # inverse points
plot.ecdf(pCantor(rCantor(10000)))      # almost straight 
plot(density(rCantor(10000), bw=0.005)) # idea of what is going on, but 
dCantor(1/4)          # no 1s in ternary 0.0202... so infinite
dCantor(1/4, continuous=FALSE)          # largely meaningless 
dCantor(1/4, continuous=FALSE, bits=50) # still meaningless      
}
