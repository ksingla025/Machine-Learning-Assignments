suppressMessages(library(R.matlab))
suppressMessages(library(Brobdingnag))
suppressMessages(library(CMA))

source('ComputeDataLikelihoods.R')
source('LikelihoodProbability.R')
source('Predict.R')
source('FDA.R')

data <- readMat('../datasets/mnist_all.mat')

# Sample and partition data into training and testing data
train.data <- NULL
test.data <- NULL
for(i in 1:10) {
  # Combine previous training and testing data
  temp <- data.frame(matrix(c(data[2*(i-1) + 1][[1]], data[2*i][[1]]), ncol=784))
  temp <- temp[sample(1:nrow(temp), 200), ]
  
  temp <- cbind(temp, rep(i-1, nrow(temp))) # Add class label as the last field
  train <- sample(1:nrow(temp), nrow(temp)/2)
  test <- -train
  train.data <- rbind(train.data, temp[train, ])
  test.data <- rbind(test.data, temp[test, ])
}
rm(data, temp, test, train) # Remove unnecessary variables

# Scale training and testing data
#train.data <- scale(train.data, center=FALSE, scale=TRUE)
#test.data <- scale(test.data, center=FALSE, scale=TRUE)

# Take PCA projection onto top 9 dims. Train and classify.
train.pca <- princomp(train.data[, 1:784], scores=TRUE)
test.proj <- predict(train.pca, test.data[, 1:784])

train.proj <- cbind(train.pca$scores[, 1:9], train.data[, 785])
test.proj <- cbind(test.proj[, 1:9], test.data[, 785])

train.likelihood <- ComputeDataLikelihoods(train.proj)

test.accuracy <- Predict(train.likelihood, test.proj, c(0:9))
cat("Accuracy on test data using PCA: ", test.accuracy)

# Take FDA projection onto 9 dims, after removing singularity. Train and classsify.
high_var <- length(which(train.pca$sdev > 1))
train.proj <- cbind(train.pca$scores[, 1:high_var], train.data[, 785])
test.proj <- predict(train.pca, test.data[, 1:784])
test.proj <- cbind(test.proj[, 1:high_var], test.data[, 785])

train.fda <- FDA(train.proj, comp=9)
train.proj <- train.proj[, 1:high_var] %*% train.fda
train.proj <- cbind(train.proj, train.data[, 785])
test.proj <- test.proj[, 1:high_var] %*% train.fda
test.proj <- cbind(test.proj, test.data[, 785])

train.likelihood <- ComputeDataLikelihoods(train.proj)

test.accuracy <- Predict(train.likelihood, test.proj, c(0:9))
cat("Accuracy on test using FDA: ", test.accuracy)
