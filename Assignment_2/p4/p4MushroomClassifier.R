p4MushroomClassifier<-function(mushroom_data, max_depth=30, 
                               print_results=TRUE) {
  library(rpart)
  
  # Split the data into 5 sets.
  k = 5
  set.seed(20)
  mushroom_data = sample(mushroom_data)
  data_samples = split(mushroom_data[1:(floor(nrow(mushroom_data)/k)*k),], rep(1:k))
  
  ## Take three sets as training data and remaining three as test data.
  n_training_sets = 3
  n_test_sets = 2
  
  # Matrix containing all combinations of testing sets.
  test_comb = combn(seq_len(k), 2)
  n_test_comb = dim(test_comb)[2]
  
  # Compute training and testing data.
  accuracy = NULL
  for(i in 1:n_test_comb) {
    training_data = NULL
    testing_data = NULL
    for(j in 1:k) {
      # rbind needs the names to be same to function.
      # split modifies the names.
      temp = as.data.frame(data_samples[j])
      names(temp) = names(mushroom_data)
      
      if(j %in% test_comb[,i]) {
        training_data = rbind(training_data, temp)
      } else {
        testing_data = rbind(testing_data, temp)
      }
    }
    
    # Build decision tree model using training data
    tree_model = rpart(category ~ ., training_data,
                       control = rpart.control(maxdepth = max_depth))
    
    # Check model on testing data
    tree_pred = predict(tree_model, testing_data, type="class")

    # Get column number of category column
    c = which(colnames(mushroom_data) == "category")
    accuracy[i] = mean(tree_pred == testing_data[, c])
  }
 
  # Print results
  if(print_results) {
    cat("Mean accuracy: ", mean(accuracy), "\n")
    cat("Standard deviation of accuracy: ", sd(accuracy))
  }
  
  list(mean(accuracy), sd(accuracy))
}