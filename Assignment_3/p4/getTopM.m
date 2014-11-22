function [ topWords ] = getTopM( M )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    

    data = [load('../datasets/test.data');load('../datasets/train.data')];
    
    uniqueWords = numel(unique(data(:,2)));
    
    wordFreq = zeros(uniqueWords,1,'double');
    
    for i=1:size(data,1)
        wordIDX = data(i,2);
        wordFreq(wordIDX) = wordFreq(wordIDX) + 1; 
    end
    
    [~,topWords] = sort(wordFreq,'descend');
    topWords = topWords(1:M,:);
    
    clear data;
end

