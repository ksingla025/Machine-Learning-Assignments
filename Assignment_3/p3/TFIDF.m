function [ tfidfRep ] = TFIDF( bagOfWords )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    IDF = sum(bagOfWords,1);
    totalWordCount = sum(IDF);
    IDF = IDF./totalWordCount;
    IDF = log(IDF).*(-1);
    
    TF = log(bagOfWords+1);
    
    tfidfRep = bsxfun(@times,TF,IDF);
    
    norms = tfidfRep.*tfidfRep;
    norms = sqrt(sum(norms,2));
    
    tfidfRep = bsxfun(@rdivide,tfidfRep,norms);

%     disp(sum(sum((tfidfRepr.*tfidfRepr),2)));

end

