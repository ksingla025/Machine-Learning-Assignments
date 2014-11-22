function [ docBow ] = BOW( tw )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    docBow = zeros(500,1000,'double');
    
    
    test_data = load('../datasets/test.data');
    train_data = load('../datasets/train.data');
    test_labels = load('../datasets/test.label');
    train_labels =load('../datasets/train.label');
    
    docs = zeros(25,20,'double');
    
    for i=1:20
        curTestLabel = find(test_labels==i);
        curTrainLabel = find(train_labels==i);
        
        
        curTestLabelSize = size(curTestLabel,1);
        selected = randperm(curTestLabelSize,10);
        docs(1:10,i) = curTestLabel(selected);
        
        curTrainLabelSize = size(curTrainLabel,1);
        selected = randperm(curTrainLabelSize,15);
        docs(11:25,i) = curTrainLabel(selected);
        
    end
    
%     disp(docs)
    
    for i=1:20
        
        for j=1:10
            curData = test_data(test_data(:,1)==docs(j,i),2:end);
            docNum = (i-1)*25 + j;
            for k=1:1000
                curWordCount = curData(curData(:,1)==tw(k),2);
                if ~isempty(curWordCount)
                    docBow(docNum,k) = curWordCount;
                end
            end
        end
        
        for j=11:25
            curData = train_data(train_data(:,1)==docs(j,i),2:end);
            docNum = (i-1)*25 + j;
            for k=1:1000
                curWordCount = curData(curData(:,1)==tw(k),2);
                if ~isempty(curWordCount)
                    docBow(docNum,k) = curWordCount;
                end
            end
        end
    end
    
    
end

