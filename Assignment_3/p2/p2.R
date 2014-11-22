suppressMessages(library(R.matlab))

source('SoftKMeans.R')
source('ComputeDegree.R')
source('Distance.R')

data <- readMat('../datasets/mnist_all.mat')

# Sample data
x <- NULL
for(i in 1:10) {
  temp <- matrix(c(data[2*(i-1) + 1][[1]], data[2*i][[1]]), ncol=784)
  x <- rbind(x, temp[sample(nrow(temp), 100), ])
}

rm(temp, data)

x.pca <- princomp(x, scores=TRUE)
x.new <- scale(x.pca$scores[, 1:50], center=TRUE, scale=TRUE)

# Values of hyper-parameters for which SoftKMeans has to be run
decay <- matrix(rep(c(0.99, 0.75, 0.5), 3), nrow=3, byrow=TRUE)
var.init <- matrix(rep(c(20, 10, 5), 3), nrow=3)

par(mfrow=c(3, 3))
for(i in 1:nrow(decay)) {
  for(j in 1:ncol(decay)) {
    x.kmeans <- SoftKMeans(x.new, 10, var.init=var.init[i, j], 
                           decay=decay[i, j], iter.max=10)
    plot.title = paste("var.init = ", as.character(var.init[i, j]), 
                       ", decay = ", as.character(decay[i, j]))
    plot(x.kmeans[[3]][complete.cases(x.kmeans[[3]])], type="b", 
         xlab="Iterations", ylab="Cluster Cost", main=plot.title)
  }
}
