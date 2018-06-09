 train_data=lasttrain(:,2:Keygenenum);
 train_label=lasttrain(:,1);
 validation_data=lastvalidation(:,2:Keygenenum);
 validation_label=lastvalidation(:,1);
 test_data1=lasttest(:,2:Keygenenum);
 test_label1=lasttest(:,1);
 test_data=test_data1(1:50,:);
 test_label=test_label1(1:50,:);
validationaccuracysum=0;
trainaccuracysum=0;
testaccuracysum=0;
for testx=1:10
 mdl = ClassificationKNN.fit(train_data,train_label,'NumNeighbors',1);  
 predict_label = predict(mdl, validation_data);  
 validationaccuracy  = length(find(predict_label == validation_label))/length(validation_label)*10;  
 validationaccuracysum=validationaccuracysum+validationaccuracy;
end
validationaccuracysum
for testx=1:10
 mdl = ClassificationKNN.fit(train_data,train_label,'NumNeighbors',1);  
 predict_label =  predict(mdl, train_data); 
 trainaccuracy = length(find(predict_label == train_label))/length(train_label)*10;  
 trainaccuracysum=trainaccuracysum+trainaccuracy;
end
trainaccuracysum
for testx=1:10
 mdl = ClassificationKNN.fit(train_data,train_label,'NumNeighbors',1);  
 predict_label = predict(mdl,test_data); 
 testaccuracy  = length(find(predict_label == test_label))/length(test_label)*10;  
 testaccuracysum=testaccuracysum+testaccuracy;
end
testaccuracysum
