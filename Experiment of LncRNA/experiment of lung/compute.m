train_data=lasttrain(:,2:Keygenenum);
 train_label=lasttrain(:,1);
 test_data1=lasttest(:,2:Keygenenum);
 test_label1=lasttest(:,1);
 test_data=test_data1(1:48,:);
 test_label=test_label1(1:48,:);
testaccuracysum=0;
for testx=1:10
 mdl = ClassificationKNN.fit(train_data,train_label,'NumNeighbors',1);  
 predict_label   =       predict(mdl,test_data); 
 testaccuracy         =       length(find(predict_label == test_label))/length(test_label)*10;  
 testaccuracysum=testaccuracysum+testaccuracy;
end
testaccuracysum
