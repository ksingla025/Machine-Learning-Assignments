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
      likelihood_prob <- LikelihoodProbability(test.data[i, 1:(test.data.ncol-1)],
                                               model[[1]][j, ],
                                               matrix(model[[2]][j, ], 
                                                      ncol=test.data.ncol-1))
      
      #print(temp_prob)
      if(likelihood_prob > max_prob) {
        max_prob <- likelihood_prob
        label.predicted <- classes[j]
      }
    }
    #print(" ")
    if(label.predicted == label.actual)
      correct <- correct + 1
  }

  accuracy <- correct/nrow(test.data)
  return(accuracy)
}