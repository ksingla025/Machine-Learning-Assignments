clc;
clear all;
close all;

tw = getTopM(1000);
bagOfWords = BOW(tw);
tfidfRep = TFIDF(bagOfWords);

% similarityMat = 1-(tfidfRep*tfidfRep');

labels = (ceil((1:500)./25))';

indices = zeros(1,500);
indices(randperm(500,250)) = 1;

trainingData = tfidfRep(indices==1,:);
trainingLabels = labels(indices==1);

testingData = tfidfRep(indices==0,:);
testingLabels = labels(indices==0);

accuracy = zeros(1,7,'double');

for k=1:2:13
    classifiedLabels = knnclassify(testingData,trainingData,trainingLabels...
                        ,k,'cosine');
    accuracy(floor((k+1)/2)) = sum(classifiedLabels==testingLabels)/250;
end

plot(1:2:13,accuracy);