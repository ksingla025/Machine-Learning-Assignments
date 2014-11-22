SphericalKMeans<-function(tfidf, k) {
  library(skmeans)
  
  clusters <- skmeans(tfidf, k)
  clusters
}