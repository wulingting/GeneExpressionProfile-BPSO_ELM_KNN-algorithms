%输入deletezeroratio
data=dealdata;
Dim=139;%样本数量
out=randperm(Dim)';%将1-Dim的数字打乱
trainnum=69;%训练集数量
validationnum=35;%验证集数量
testnum=35;%测试集数量
train=out(1:trainnum);
validation=out(trainnum+1:trainnum+validationnum);
test=out(trainnum+validationnum+1:Dim);
%分为样本和验证
for i=1:trainnum
traindata(:,i)=dealdata(:,train(i)+1);
end
for i=1:validationnum
validationdata(:,i)=dealdata(:,validation(i)+1);
end
for i=1:testnum
testdata(:,i)=dealdata(:,test(i)+1);
end
traindata=traindata';
validationdata=validationdata';
testdata=testdata';
for i=1:trainnum
   if traindata(i,1)>=89 
       traindata(i,1)=1;
   else 
       traindata(i,1)=0;
   end 
end
for i=1:validationnum
   if validationdata(i,1)>=89
       validationdata(i,1)=1;
   else 
       validationdata(i,1)=0;
   end 
end
for i=1:testnum
   if testdata(i,1)>=89
       testdata(i,1)=1;
   else 
       testdata(i,1)=0;
   end 
end
%加上分类
%n＝10


%% 初始化程序:
Keygenenum=5;
Dim=120;%粒子的维数,选取的lncRNA的数量
xSize=5;%种群数  
MaxIt=10;%最大迭代次数
c1=2;
c2=2;%定义加速因子
w=0.8;%定义惯性因子
%%
for csx=1:xSize
out=randperm(Dim)';
data=out(1:10);
for cxy=1:Dim
   x(csx,cxy)=0;    
end
for cxy=1:Keygenenum
   x(csx,data(cxy))=1;    
end
end
%%随机生成粒子位置
v=rand(xSize,Dim);%粒子的初始速度
xbest=zeros(xSize,Dim);%单个粒子的初始最佳位置
fxbest=zeros(xSize,1);%xbest的适应度
gbest=zeros(1,Dim);%粒子群的初始最佳位置
fgbest=0;%gbest的适应度
ybnum=trainnum;%样本数量
yznum=validationnum;%验证数量
csnum=testnum;%测试数量
%粒子群最优位置和单个粒子最优位置的选定
%% 迭代循环算法:
iter=0;
t1=clock;  
while iter<MaxIt
     LoadingTime=0;TrainingTime=0;TestingTime=0;TrainingAccuracy=0;TestingAccuracy=0;
    iter=iter+1;

     for xSizenum=1:xSize
    for i=1:ybnum
      train(i,1)=traindata(i,1);
    end
    %设置训练集初始化
        for i=1:yznum
      validation(i,1)=validationdata(i,1);
    end
   %设置验证集初始化
   for z=1:ybnum%1-43
           dimnum=1;
    for i=1:Dim%1-200
       if(x(xSizenum,i)==1)
            dimnum=dimnum+1;
           train(z,dimnum)=traindata(z,i+1);  
       end
    end
   end
    %设置训练集初始化
    
   for z=1:yznum%1-20
           dimnum=1;
    for i=1:Dim%1-200
       if(x(xSizenum,i)==1)
            dimnum=dimnum+1;
           validation(z,dimnum)=validationdata(z,i+1);  
       end
    end
   end
  %设置验证集初始化
    
    
   LoadingTime=0;TrainingTime=0;TestingTime=0;TrainingAccuracy=0;TestingAccuracy=0;
testsum=0;
for testx=1:10
   [LoadingTime,TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm(train, validation, 1,40,'sig');
   testsum=testsum+TestingAccuracy;
end
fx(xSizenum)=testsum;
 end
    %求出elm
    %fx=elm精度
  for i=1:xSize
      su=0;
      for sunum=1:Dim
      su=su+x(i,sunum);
      end
        if su>Keygenenum
            fx(i)=0;%当被包内物品的体积超过限制时,将期适应度设置为1
        end
  end
 
    for i=1:xSize
        if fxbest(i)<fx(i)
            fxbest(i)=fx(i);
            xbest(i,:)=x(i,:);%当粒子的适应度fx(i)大于其最佳适应度时fxbest(i),用其替代原来粒子的最佳适应度,并记下此解
        end
    end
    if fgbest<max(fxbest)
        [fgbest,g]=max(fxbest);
        gbest=xbest(g,:);%当存在粒子的最佳适应度fxbest(g)大于种群的最佳适应度时,用其替代原来种群的最佳适应度,并记下此解
    end
       for i=1:ybnum
      lasttrain(i,1)=traindata(i,1);
    end
    %最后训练初始化
        for i=1:yznum
      lastvalidation(i,1)=validationdata(i,1);
        end
    %最后验证初始化
        for i=1:yznum
      lastvalidation(i,1)=validationdata(i,1);
        end
    %最后验证初始化
         for i=1:csnum
      lasttest(i,1)=testdata(i,1);
        end
    %最后初测试始化
     for z=1:ybnum%1-43
           dimnum=1;
    for i=1:Dim%1-200
       if(gbest(i)==1)
            dimnum=dimnum+1;
           lasttrain(z,dimnum)=traindata(z,i+1);  
       end
    end
   end
   
    
   for z=1:yznum%1-20
           dimnum=1;
    for i=1:Dim%1-200
       if(gbest(i)==1)
            dimnum=dimnum+1;
           lastvalidation(z,dimnum)=validationdata(z,i+1);  
       end
    end
   end
   
    for z=1:csnum%1-20
           dimnum=1;
    for i=1:Dim%1-200
       if(gbest(i)==1)
            dimnum=dimnum+1;
           lasttest(z,dimnum)=testdata(z,i+1);  
       end
    end
   end
   
   
    for i=1:Dim
        dimnum=0;
        if (gbest(i)==1)
            dimnum=dimnum+1;
            last(dimnum)=i;
            mylast(iter,dimnum)=i;
        end
    end
      ass=0;
    for i=1:Dim
    if (gbest(i)==1)
            ass=ass+1;
            last(ass)=i;
    end
    end 
    for i=1:xSize
        if x(i,:)==gbest
            x(i,:)=round(rand(1,Dim));%为防止算法陷入局部最优，若某个粒子的位置等于种群最佳位置，将对该粒子的位置重新初始化赋值
        end
    end
    R1=rand(xSize,Dim);
    R2=rand(xSize,Dim); 
    v=v*w+c1*R1.*(xbest-x)+c2*R2.*(repmat(gbest,xSize,1)-x);%用速度迭代公式产生新的速度
    x=x+v;%更新粒子群的位置
    for i=1:xSize
        a=x(i,:);
        [b,t]=sort(a);
        wz=t(Dim-xSize:Dim);
        wzpx=sort(wz);
        wzpx(Keygenenum+1)=0;
        num=1;
         for j=1:Dim
             if j==wzpx(num)
                 num=num+1;
               if(x(i,j)>0.5)
                 x(i,j)=1;
               else
                  x(i,j)=1;
                end 
             else x(i,j)=0;
            end
        end

    end%由于粒子的位置只有(0,1)两种状态,此处以0.5为分界点对函数值进行离散化
    mygbest(iter)=fgbest;
    iter
    fgbest
 
end
t2=clock;
etime(t2,t1)  
%     for i=1:ybnum
%       lasttrain(i,1)=traindata(i,1);
%     end
%     %最后训练初始化
%         for i=1:yznum
%       lasttest(i,1)=testdata(i,1);
%         end
%     %最后测试初始化
%      for z=1:ybnum%1-43
%            dimnum=1;
%     for i=1:Dim%1-200
%        if(gbest(i)==1)
%             dimnum=dimnum+1;
%            lasttrain(z,dimnum)=traindata(z,i+1);  
%        end
%     end
%    end
%    
%     
%    for z=1:yznum%1-20
%            dimnum=1;
%     for i=1:Dim%1-200
%        if(gbest(i)==1)
%             dimnum=dimnum+1;
%            lasttest(z,dimnum)=testdata(z,i+1);  
%        end
%     end
%    end
% 
%     ass=0;
%     for i=1:Dim
%     if (gbest(i)==1)
%             ass=ass+1;
%             last(ass)=i;
%         end
%     end  


            