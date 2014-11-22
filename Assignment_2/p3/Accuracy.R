Accuracy<-function(h) {
  n_rows = nrow(mushroom_data)
  n_attr = ncol(mushroom_data) - 1
  n_satisfied = 0
  
  for(i in 1:n_rows) {
    satisfy = Satisfies(h, mushroom_data[i, ])
    if(mushroom_data[i, 1] == 'p' && satisfy) {
      n_satisfied = n_satisfied + 1
    } else if(mushroom_data[i, 1] == 'e' && !satisfy) {
      n_satisfied = n_satisfied + 1
    }
  }

  accuracy = n_satisfied/n_rows
  accuracy
}