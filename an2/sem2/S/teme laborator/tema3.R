func <- function()
{
    x = rnorm(1000, 20, 4)
    
    i=0
    for(i in 1:5)
    {
         print(mean(sample(x, 200 + 25 * i)))
    }
}

makeMenu <- function()
{
    c = menu(c("1", "2", "3"), graphics = TRUE, title = "Alegeti!")
    statdesc(1000, c)
}

statdesc <- function(n, c)
{
    if(c == 1)
    {
        x = rnorm(n, 20, 4)
    
        sum = 0
        for(i in 1:n)
        {
            sum = sum + (x[i] - mean(x)) ^ 2
        }
        sigma2 = sum / (n-1)
        print(sigma2)
    }

    if(c == 2)
    {
        y = rpois(n, 4)
        print(summary(y)[2])
    }

    if(c == 3)
    {
        z = rexp(n)
        print(summary(z)[4])
    }
}