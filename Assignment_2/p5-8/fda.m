function [ fdcomps ] = fda(  )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

    load mnist_all

    clear test*
    
    fvlen = size(train0,2);
    classMeans = zeros(10,fvlen,'double');
    
    trmat = 'train';
    totalSamples = 0;
    wholeMean = zeros(1,fvlen,'double');
    
    for i=0:9
        curmat = eval(strcat(trmat,char(48+i)));
        classMeans(i+1,:) = mean(curmat);
        classSize = size(curmat,1);
        wholeMean(1,:) = wholeMean(1,:) + classSize.*classMeans(i+1,:);
        totalSamples = totalSamples + classSize;
    end
    
    wholeMean = wholeMean./totalSamples;
    
    meansAdjusted = bsxfun(@minus,classMeans,wholeMean);
    
    Q = orth(meansAdjusted');
    fdcomps = Q(:,1:9);
    
    clear train*
end


