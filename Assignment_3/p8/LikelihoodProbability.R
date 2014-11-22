LikelihoodProbability <- function(x, mean, covar) {
  # Computes the likelihood probability for a data point.
  # Data point should not have the class label.
  
  covar.det = as.brob(det(covar))
  D = length(x)
  Z = as.brob(((2*pi)^(D/2)) * (sqrt(covar.det)))
  result = (1/Z) * brob(-0.5 * (t(x - mean) %*% solve(covar) %*% (x - mean)))
  return(result)
}