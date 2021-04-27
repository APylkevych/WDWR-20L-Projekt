library(tmvtnorm)

df = 5
mu = c(45, 35, 40)
sigma = matrix(c(1, -2, -1, -2, 36, -8, -1, -8, 9), 3, 3)
lower = c(20,20,20)
upper=c(50,50,50)

data <- rtmvt(n=1000, mu, sigma, df, lower, upper)

write.table(data, "d:/WDWR/Scenarios.txt", sep=" ", col.names = F, row.names = F)





