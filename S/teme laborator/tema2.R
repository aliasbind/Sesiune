x = runif(1000)
y = rexp(1000)
lenx = length(x)
leny = length(y)
minx = min(x)
miny = min(y)
maxx = max(x)
maxy = max(y)
meanx = mean(x)
meany = mean(y)
varx = var(x)
vary = var(y)

mdat <- matrix(c(minx,miny,maxx,maxy,lenx,leny,meanx,meany,varx,vary), 
nrow=5, ncol=2, byrow=TRUE,
dimnames = list(c("min","max","length","mean","var"), c("unif", "exp")))

print_hists <- function()
{
    par(mfrow=c(2,1))
    hist(x)
    hist(y)
}
