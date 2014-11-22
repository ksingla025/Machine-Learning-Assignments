function [ initMeans ] = ffp( data,k )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
       
    [numsamples,fvlen] = size(data);
    initMeans = zeros(k,fvlen,'double');
    
    meanWhole = mean(data);

    distFromMean = bsxfun(@minus,data,meanWhole);
    meanDist =  sum(distFromMean.^2,2);
    
    [~ , maxI] = max(meanDist);
    
    initMeans(1,:) = data(maxI,:);
    
    for i=2:k
        
        
       M = 1e-9;
       newMean = 1;
        
       for j=1:numsamples
            D = bsxfun(@minus,initMeans,data(j,:));
            
            mD = min(sum(D.^2,2));
            
            if mD > M
                newMean = j;
                M = mD;
            end
            
       end
       
       initMeans(i,:) = data(newMean,:);
       
    
    end
    
    
end

