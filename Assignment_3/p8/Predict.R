Predict <- function(model, test.data, classes) {
  # Compute accuracy of a model on a test data.
  # Last attribute of test.data is supposed to be the class label.
  
  test.data.ncol <- ncol(test.data)
  class.count <- length(classes)
  
  correct <- 0 # Correctly predicted
  for(i in 1:nrow(test.data)) {
    max_prob <- 0
    label.predicted <- 0
    label.actual <- test.data[i, test.data.ncol]
    
    for(j in 1:class.count) {
      for(k in 1:3) {
        likelihood_prob <- likelihood_prob + model[[j]]$alpha[k] * 
                        as.numeric(LikelihoodProbability(test.data[i, 1:(test.data.ncol-1)],
                                            model[[j]]$means[k, ],
                                            matrix(model[[j]]$cov[k, ], 
                                                  ncol=test.data.ncol-1)))
        
      }
      
      if(likelihood_prob > max_prob) {
        max_prob <- likelihood_prob
        label.predicted <- classes[j]
      }
    }
    
    if(label.predicted == label.actual)
      correct <- correct + 1
  }
  
  accuracy <- correct/nrow(test.data)
  return(accuracy)
}