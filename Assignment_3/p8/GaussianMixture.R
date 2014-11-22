GaussianMixture <- function(x, K = 3, iter.max = 100) {
  # Data should not have class labels
  
  x <- scale(x)
  
  N <- nrow(x) # Number of data points
  D <- ncol(x) # Number of features
  
  # Initialize weights randomly
  w <- matrix(rnorm(N), nrow = N, ncol = K)
  w <- w / rowSums(w)
  
  alpha <- rep(0, K) # Mixture weights
  x.means <- matrix(0, nrow = K, ncol = D) # Means vector
  x.cov <- matrix(0, nrow = K, ncol = D*D) # Covariance matrix (matrices)
  
  for(j in 1:iter.max) {
    # Maximization Step
    alpha <- colSums(w)/N
    for(k in 1:K) {
      Nk <- sum(w[, k])
      x.means[k, ] <- (1/Nk) * (w[, k] %*% x[, 1:D])
      x.cov[k, ] <- as.numeric((1/Nk) * (w[, k] * t(x[, 1:D] - x.means[k, 1:D])) %*% 
                                           (x[, 1:D] - x.means[k, 1:D]))
    }
    
    # Expectation Step
    for(i in 1:N) {
      for(k in 1:K) {
        w[i, k] <- alpha[k] * as.numeric(LikelihoodProbability(x[i, 1:D], 
                                                    x.means[k, ], 
                                                    matrix(x.cov[k, ], nrow = D)))
      }
      w[i, ] <- w[i, ] / sum(w[i, ])
    }
  }
  
  return(list(alpha = alpha, means = x.means, cov = x.cov))
}