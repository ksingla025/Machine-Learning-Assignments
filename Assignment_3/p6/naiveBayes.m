function [ assignedLabels ] = naiveBayes(testing_data ,training_data ,...
                                            training_labels)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    numClasses = numel(unique(training_labels));
    [numTrainSamples,numDimensions] = size(training_data);
    numTestSamples = size(testing_data,1);
    
    assignedLabels = zeros(numTestSamples,1);
    
    priors = zeros(numClasses,1,'double');
    
    for i=1:numTrainSamples
        priors(training_labels(i)) = priors(training_labels(i)) + 1;
    end
    
    priors = priors/numTrainSamples;
    priors = log(priors+1);
          
    classConditional = zeros(numClasses,numDimensions,'double');

    for j=1:numClasses

        curClassData = training_data(training_labels==j,:);
        totalWords = numDimensions + sum(sum(curClassData));
        
        for k=1:numDimensions
            classOccurences = 1 + sum(curClassData(:,k));
            
            classConditional(j,k) = log(classOccurences/totalWords); 
        end
        
    end
        
    for i=1:numTestSamples
        posterior = zeros(numClasses,1,'double');
        
%         maxLogLikelihood = sum(sum(bsxfun(@times,classConditional,...
%                                         testing_data(i,:)),[],2));
        
        for j=1:numClasses
            posterior(j) = sum((classConditional(j,:)+priors(j)).*...
                                           testing_data(i,:));
        end
        
        [~,assignedLabels(i)] = max(posterior);
        
    end
    
end

