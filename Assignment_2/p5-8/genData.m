function [ data,labels ] = genData(  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    load mnist_all
    
    clear test*
    
    data = double([train0;train1;train2;train3;train4;train5;train6;...
                    train7;train8;train9;]);
    
    labels = zeros(size(data,1),1,'double');
    
    trmat = 'train';
    e = 0;
    
    for i=0:9
        
        curmat = eval(strcat(trmat,char(48+i)));
        s = e + 1;
        e = s + size(curmat,1) -1;
        labels(s:e) = i;
    end
    
    clear train*
end

