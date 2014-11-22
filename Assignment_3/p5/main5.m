clc;
clear all;
close all;

data = csvread('../datasets/mushroom_binary_features.txt');
labels = data(:,1)+1;
data = data(:,2:end);

[numSamples,numDimensions] = size(data);
numTrainSamples = ceil(0.6*(numSamples));
numTestSamples = numSamples - numTrainSamples;

trInd = randperm(numSamples,numTrainSamples);
teInd = setdiff(1:numSamples,trInd);

training_data = data(trInd,:);
testing_data = data(teInd,:);


training_labels = labels(trInd);
testing_labels = labels(teInd);

assignedLabels = naiveBayes(testing_data,training_data,training_labels);

accuracy = sum(assignedLabels==testing_labels)/numTestSamples;

disp(accuracy);
