testsum100=0;
for testx=1:100
   [LoadingTime,TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm(lasttrain,lasttest, 1,40,'sig');
   testsum100=testsum100+TestingAccuracy;
end
testsum100
