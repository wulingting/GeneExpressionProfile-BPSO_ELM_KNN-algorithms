testsum100=0;
for testx=1:100
   [LoadingTime,TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm(lasttrain,lasttest, 1,30,'sig');
   testsum100=testsum100+TestingAccuracy;
end
testsum100