SoftKMeans <- function(x, centers.count, var.init, decay, m=2, iter.max=100) {
  # Compute Soft K-means on the given data.
  # Args:
  #   x: data frame
  #   centers.count: number of centers
  #   var.init: initial value of variance
  #   decay: decay constant
  #   m: degree of fuzzification  
  #   iter.max: maximum number of iterations
  
  rows.count <- nrow(x)
  
  # Declare a n*k matrix to store degrees of association
  delta <- matrix(1/centers.count, centers.count, nrow=rows.count)
  
  # Randomly initialize the k cluster centers
  centers <- x[sample(rows.count, centers.count), ]

  # Update delta matrix
  for(j in 1:rows.count) {
    delta.sum = 0
    for(k in 1:centers.count) {
      delta[j, k] = ComputeDegree(x[j, ], centers[k, ], var.init)
      delta.sum = delta.sum + delta[j, k]
    }
    delta[j, ] <- delta[j, ] / delta.sum
  }
    
  # Start computation
  clustering_cost <- NULL
  var <- var.init
  for(i in 1:iter.max) {
    clustering_cost[i] <- 0
    var <- decay * var
    
    # Recompute centers
    for(k in 1:centers.count) {
      temp <- (delta[, k] ^ m)
      centers[k, ] <- (temp %*% x)/sum(temp)
    }
    
    # Update delta matrix
    for(j in 1:rows.count) {
      delta.sum = 0
      for(k in 1:centers.count) {
        delta[j, k] <- ComputeDegree(x[j, ], centers[k, ], var)
        delta.sum = delta.sum + delta[j, k]
      }
      
      # Normalize deltas
      for(k in 1:centers.count) {
        delta[j, k] <- delta[j, k] / delta.sum
      }
    }
    
    # Compute cluster cost
    for(j in 1:rows.count) {
      for(k in 1:centers.count) {
        clustering_cost[i] <- clustering_cost[i] + 
          (delta[j, k] ^ m) * Distance(x[j, ], centers[k, ])
      }
    }
  }
  
  # Return centers and delta matrix
  list(centers, delta, clustering_cost)
}