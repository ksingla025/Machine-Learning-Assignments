ComputeNewHypothesis<-function(h) {
  # Only to be called from p3.R
  
  n_attr = length(h)
  new_h = h
  max_accuracy = 0
  
  for(i in 1:n_attr) {
    if(h[i] == '?') {
      for(j in unique_val[[i]]) {
        temp_h = h
        temp_h[i] = j
        accuracy = Accuracy(temp_h)
        if(accuracy > max_accuracy) {
          max_accuracy = accuracy
          new_h = temp_h
        }
      }
    } else {
      for(j in unique_val[[i]]) {
        temp_h = h
        if(! grepl(j, temp_h[i])) {
          temp_h[i] = paste(temp_h[i], j, sep="")
          accuracy = Accuracy(temp_h)
          if(accuracy > max_accuracy) {
            max_accuracy = accuracy
            new_h = temp_h
          }
        }
      }
    }
  }
  
  new_h
}