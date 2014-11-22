clc;
clear all;
close all;

data = [load('../datasets/train.data');load('../datasets/test.data')];
labels = [load('../datasets/train.label');load('../datasets/test.label')];

tw = getTopM(10000);

numSamples = numel(labels);
numTrainSamples = ceil(0.1*(numSamples));
numTestSamples = numSamples - numTrainSamples;

training_data = zeros(numTrainSamples,10000,'double');
testing_data = zeros(numTestSamples,10000,'double');

trInd = randperm(numSamples,numTrainSamples);
teInd = setdiff(1:numSamples,trInd);

for i=1:numTrainSamples
    curData = data(data(:,1)==trInd(i),2:end);
    
    for j=1:10000
        training_data(i,j) = sum(curData(curData(:,1)==tw(j),2));
    end
end

for i=1:numTestSamples
    curData = data(data(:,1)==teInd(i),2:end);
    
    for j=1:10000
        testing_data(i,j) = sum(curData(curData(:,1)==tw(j),2));
    end
end

training_labels = labels(trInd);
testing_labels = labels(teInd);

assignedLabels = naiveBayes(testing_data,training_data,training_labels);

accuracy = sum(assignedLabels==testing_labels)/numTestSamples;

disp(accuracy);
