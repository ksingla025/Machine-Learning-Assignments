ComputeDegree <- function(x, m, v) {
  # Computes degree of association of a data point 'x' with a cluster
  # center 'm', using the value of variance 'v'
  
  result = exp(-1 * (sqrt(sum((x - m)^2))/v)^2)
  result
}