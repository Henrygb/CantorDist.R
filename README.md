# CantorDist.R
Cantor distribution in R

Provides pCantor qCantor rCantor (and an unhelpful dCantor) functions for use in R

Examples

```
qCantor(1/4)          # 1/4 binary 0.01 times2 0.02 tern2dec 2/9
#[1] 0.2222222
qCantor(1/2)          # median actually between 1/3 and 2/3
#[1] 0.6666667
pCantor(1/4)          # 1/4 ternary 0.0202... div2 0.0101... bin2dec 1/3
#[1] 0.3333333
pCantor(1/3)          # median actually between 1/3 and 2/3
#[1] 0.5
pCantor(2/3)          # median actually between 1/3 and 2/3
#[1] 0.5

mean(rCantor(100000)) # ~ = 1/2
#[1] 0.499615
var( rCantor(100000)) # ~ = 1/8
#[1] 0.1249062

plot.ecdf(rCantor(100000))               # Devil's staircase
plot(pCantor, type="p")                  # Devil's staircase points 
plot(qCantor, type="p")                  # inverse points
plot.ecdf(pCantor(rCantor(10000)))       # almost straight
plot(density(rCantor(100000), bw=0.005)) # idea of what is going on, but

dCantor(1/4)          # no 1s in ternary 0.0202... so infinite
#[1] Inf
dCantor(1/4, continuous=FALSE)           # largely meaningless
#[1] 3.178138e-07
```