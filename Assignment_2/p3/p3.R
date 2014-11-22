source('Satisfies.R')
source('ComputeNewHypothesis.R')
source('Accuracy.R')

mushroom_data <- read.csv('../datasets/mushroom_data.txt')
# Sample data
train = sample(1:nrow(mushroom_data), 1000)
mushroom_data <- mushroom_data[train, ]

n_attr <- ncol(mushroom_data) - 1

# List unique values for each attribute
unique_val <- NULL
for(i in 1:n_attr+1) {
  unique_val <- append(unique_val, list(as.character(unique(mushroom_data[, i]))))
}

# Set containing all the hypotheses
H <- NULL

# Insert the most general hypothesis as the first
last_h <- rep('?', n_attr)
H <- rbind(H, last_h)
t <- 0

new_h <- ComputeNewHypothesis(last_h)

while(Accuracy(new_h) >= Accuracy(last_h)) {
  last_h <- new_h
  new_h <- ComputeNewHypothesis(last_h)
  H <- rbind(H, last_h)
}