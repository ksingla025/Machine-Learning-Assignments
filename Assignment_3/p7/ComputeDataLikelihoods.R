ComputeDataLikelihoods <- function(data) {
  # Computes data likelihood probabilities for each class and dimension.
  # Last attribute is assumed to be the class label.
  
  classes <- unique(data[, ncol(data)])
  class.count <- length(classes)
  feature.count <- ncol(data)-1
  
  likelihood.means <- matrix(0, nrow=class.count, ncol=feature.count)
  likelihood.covar <- matrix(0, nrow=class.count, ncol=feature.count^2)
  
  for(i in 1:class.count) {
    temp <- data[which(data[, ncol(data)] == classes[i]), 1:feature.count]
    likelihood.covar[i, ] <- as.numeric(cov(temp))
    likelihood.means[i, ] <- colMeans(temp)
  }
  
  list(likelihood.means, likelihood.covar)
}