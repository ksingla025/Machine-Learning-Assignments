function [ meanMSE,stdMSE,meanPurity,stdPurity ] =  calcKmeans( data,...
                                                                labels,...
                                                                k,repeat,...
                                                                init,...
                                                                initMeans,...
                                                                projComp,...
                                                                imname)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    
    
    [numsamples,fvlen] = size(data);
    clabel = zeros(numsamples,repeat,'double');
    cpos = zeros(k,fvlen,repeat,'double');
    
    for i=1:repeat
        if init == 0
            [clabel(:,i),cpos(:,:,i)] = kmeans(data,k);
        else
            [clabel(:,i),cpos(:,:,i)] = kmeans(data,k,'Start',initMeans);
        end
    end
    
    MSE = zeros(repeat,1,'double');
    
    for i=1:repeat
        for j=1:k
                curClassErr = bsxfun(@minus,data(clabel(:,i)==j),cpos(j,:,i));
                MSE(i) = MSE(i) + sum(sum(curClassErr.*curClassErr,2));
        end
%         MSE(i) = MSE(i)/numsamples;
    end
    
    meanMSE = mean(MSE);
    stdMSE = sqrt(sum((MSE-meanMSE).^2));
    
    purity = zeros(repeat,1,'double');
    
    for i=1:repeat
        clusterMembershipMatrix = zeros(k,10,'double');
        for n=1:numsamples
            clusterMembershipMatrix(clabel(n,i),labels(n)+1) = clusterMembershipMatrix(clabel(n,i),labels(n)+1) + 1;
        end
        purity(i) = sum(max(clusterMembershipMatrix,[],2))/numsamples;
    end
    
    meanPurity = mean(purity);
    stdPurity = sqrt(sum((purity-meanPurity).^2));
    
    imRows = k/5;
    
    if numel(projComp) 
        centers = cpos(:,:,1)*projComp';
    else
        centers = cpos(:,:,1);
    end
    
    figure;
    for i=1:k
        subplot(imRows,5,i),imshow(reshape(centers(i,:),[28 28]),[0 255]);
    end
    saveas(gcf,imname,'png');
    
end

