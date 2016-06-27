#read TEST data and make batch
x <- read.table("/home/suzuki/LSTM_tsc-master/data/TEST_batch2000", sep=",")
y <- x[sample(nrow(x), 30),]
print(y[1,])
z1 <- 0
z2 <- 0
z1 <- sum(y[1,])
n <- dim(y)[2]
for (i in 1:n) {
  z2 <- z2 + y[1,i]     
}         
print(z2)
print(z1)
