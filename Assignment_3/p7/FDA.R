FDA <- function(X, comp=1) {
  # Computes Fisher discriminants for data X.
  # Last attribute of the data must be the class labels.
  
  feature.count <- ncol(X)-1
  if(comp >= feature.count) {
    stop("Cannot compute discriminants. Too high value of 'comp'.", call. = TRUE)
  }
  class.labels <- X[, ncol(X)]
  X <- X[, 1:(ncol(X)-1)]
  classes <- unique(class.labels)
  class.count <- length(classes)
  data.mean <- colMeans(X)
  
  Sw <- matrix(0, feature.count, feature.count)
  Sb <- matrix(0, feature.count, feature.count)
  for(i in 1:class.count) {
    temp <- as.matrix(X[which(class.labels == classes[i]), ])
    m <- colMeans(temp)

    Sw <- Sw + t(temp - m) %*% (temp - m)
    Sb <- Sb + nrow(temp) * (m - data.mean) %*% t(m - data.mean)
  }
  
  Swb <- solve(Sw) %*% Sb
  eig <- eigen(Swb)
  eig$val <- as.double(eig$val[1:comp])
  eig$vectors <- matrix(as.double(eig$vectors[, 1:comp]), ncol=comp)
  eig$vectors # Columns contain the eigen vectors
}