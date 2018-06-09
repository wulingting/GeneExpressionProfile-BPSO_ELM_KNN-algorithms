validationsum100=0;
testsum100=0;
trainsum100=0;
for validationtx=1:100
   [LoadingTime,TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm(lasttrain,lastvalidation, 1,30,'sig');
   validationsum100=validationsum100+TestingAccuracy;
end
validationsum100

for testx=1:100
   [LoadingTime,TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm(lasttrain,lasttest, 1,30,'sig');
   testsum100=testsum100+TestingAccuracy;
end
testsum100


for trainx=1:100
   [LoadingTime,TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm(lasttrain,lasttrain, 1,30,'sig');
   trainsum100=trainsum100+TestingAccuracy;
end
trainsum100