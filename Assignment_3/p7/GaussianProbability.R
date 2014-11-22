GaussianProbability <- function(x, mean, sd) {
  (1/(2*pi)) * exp(-1 * ((x - mean)^2)/(2 * sd^2))
}