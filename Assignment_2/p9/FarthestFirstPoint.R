FarthestFirstPoint<-function(tfidf, k) {
  # Required for simple_triplet_matrix
  library(slam)
  
  # Number of cluster centers calculated
  calculated <- 0
  cluster_centers <- NULL
  
  # Find the mean of all the points
  temp <- t(as.simple_triplet_matrix(col_means(tfidf)))
  min_dist <- 1e10
  
  # Set the point farthest from the mean as the first cluster center
  mean <- NULL
  max_dist <- 0
  farthest_point <- NULL
  for(i in 1:nrow(tfidf)) {
    product <- temp * tfidf[i, ]
    numerator <- row_sums(product)
    denominator <- sqrt(row_sums(temp^2) * row_sums(tfidf[i, ]^2))
    dist <- numerator/denominator
    if(dist > max_dist) {
      max_dist <- dist
      farthest_point <- tfidf[i, ]
    }
  }
  cluster_centers <- rbind(cluster_centers, farthest_point)
  calculated <- 1
  
  # Compute the remaining cluster centers
  for(i in 2:k) {
    # To calculate the new cluster center, find a point farthest
    # from the current cluster centers.
    max_dist <- 0
    farthest_point <- NULL
    for(d_id in 1:nrow(tfidf)) {
      # Minimum distance of the current point from the already selected
      # cluster centers.
      min_dist <- -1e10
      for(c_id in 1:calculated) {
        product <- cluster_centers[c_id, ] * tfidf[d_id, ]
        dist <- row_sums(product)/sqrt(row_sums(cluster_centers[c_id, ] ^ 2)
                                       * row_sums(tfidf[d_id, ] ^ 2))
        if(dist < min_dist) {
          min_dist <- dist
        }
      }
    
      # Find the point whose minimum distance from all the clusters
      # is the maximum.
      if(max_dist > min_dist) {
        max_dist <- min_dist
        farthest_point <- tfidf[d_id, ]
      }
    }
    
    cluster_centers <- rbind(cluster_centers, farthest_point)
    calculated <- calculated + 1
  }
  
  cluster_centers
}