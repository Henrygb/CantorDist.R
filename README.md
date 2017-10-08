# CantorDist.R
Cantor distribution in R

Provides pCantor qCantor rCantor (and an unhelpful dCantor) functions for use in R

Examples

```
qCantor(0.249999999) 
# 1/4 binary 0.001111... times2 0.002222... tern2dec 1/9
qCantor(0.250000001) 
# 1/4 binary 0.010000... times2 0.020000... tern2dec 2/9
qCantor(1/4)         
# lower quartile between 1/9 and 2/9 

qCantor(1/2)         
# median actually between 1/3 and 2/3
pCantor(1/4)         
# 1/4 ternary 0.0202... div2 0.0101... bin2dec 1/3
pCantor(1/3)         
# median actually between 1/3 and 2/3
pCantor(2/3)         
# median actually between 1/3 and 2/3

mean(rCantor(100000))                   # ~ = 1/2
var( rCantor(100000))                   # ~ = 1/8

plot.ecdf(rCantor(10000))               
# Devil's staircase      
plot(pCantor, type="p")                 
# Devil's staircase points        
plot(qCantor, type="p")                 
# inverse points
plot.ecdf(pCantor(rCantor(10000)))      
# almost straight 

plot(density(rCantor(10000), bw=0.005)) # idea of what is going on, but 
dCantor(1/4)          # no 1s in ternary 0.0202... so infinite
dCantor(1/4, continuous=FALSE)          # largely meaningless 
dCantor(1/4, continuous=FALSE, bits=50) # still meaningless      
```
