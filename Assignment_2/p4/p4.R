source('p4MushroomClassifier.R')

mushroom_data = read.csv('../datasets/mushroom_data.txt')

# Compute accuracy and standard deviation
p4MushroomClassifier(mushroom_data)

# Compute accuracies for different values of max depth
depth_values = c(4, 8, 12, 16, 20)
accuracy = vector()
for(i in 1:length(depth_values)) {
  accuracy[i] = p4MushroomClassifier(mushroom_data, depth_values[i], FALSE)[1]
}

plot(depth_values, accuracy)
text(depth_values, 
     lapply(accuracy, function(x) x + 0.05),
     lapply(accuracy, function(x) round(x, 2)))