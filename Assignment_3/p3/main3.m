clear all;
close all;
clc;

tw = getTopM(1000);
bagOfWords = BOW(tw);
tfidfRep = TFIDF(bagOfWords);


method = {'single','complete','average','centroid'};




for j=1:4
    
    cluster_purity = zeros(5,1,'double');
    
    for i=10:10:50
        cluster = agglomClustering(tfidfRep,i,method(j));
        
        clusterXClass = zeros(i,20,'double');
    
        numSamps = size(cluster,1);
        
        for k = 1:numSamps
            clstr = cluster(k);
            class = ceil(k/25);
            clusterXClass(clstr,class) = clusterXClass(clstr,class) + 1; 
        end
        
        curInd = floor(i/10);
        
        cluster_purity(curInd) = sum(max(clusterXClass,[],2))./numSamps;
            
    end
    
    subplot(4,1,j),plot(10:10:50,cluster_purity);
               
end
