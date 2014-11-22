function [ clusterMat ] = agglomClustering( tfidfRep,numClusters,method )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    
    clusterMat = clusterdata(tfidfRep,'linkage',method,'maxclust',...
                            numClusters,'distance','cosine');

end

