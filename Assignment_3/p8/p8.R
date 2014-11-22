suppressMessages(library(R.matlab))
suppressMessages(library(Brobdingnag))
suppressMessages(library(mixtools))

source('GaussianMixture.R')
source('LikelihoodProbability.R')
source('Predict.R')

data <- readMat('../datasets/mnist_all.mat')

# Sample and partition data into training and testing data
train.data <- NULL
test.data <- NULL
for(i in 1:10) {
  # Combine previous training and testing data
  temp <- data.frame(matrix(c(data[2*(i-1) + 1][[1]], data[2*i][[1]]), ncol=784))
  temp <- temp[sample(1:nrow(temp), 200), ]
  temp <- rbind(temp, rep(i-1, nrow(temp)))
  
  temp <- cbind(temp, rep(i-1, nrow(temp))) # Add class label as the last field
  train <- sample(1:nrow(temp), nrow(temp)/2)
  test <- -train
  train.data <- rbind(train.data, temp[train, ])
  test.data <- rbind(test.data, temp[test, ])
}
rm(data, temp, test, train) # Remove unnecessary variables

colnames(train.data)[785] <- "class"
colnames(test.data)[785] <- "class"

train.data <- as.matrix(train.data)
test.data <- as.matrix(test.data)

params <- array(list(), 10) # List to store parameters for each class

# Compute parameters for each class
for(i in 1:10) {
  x <- train.data[which(train.data[, "class"] == (i-1)), 1:784]
  params[[i]] <- GaussianMixture(x)
}

