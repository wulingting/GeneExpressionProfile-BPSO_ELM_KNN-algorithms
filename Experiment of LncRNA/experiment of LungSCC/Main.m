%����deletezeroratio
data=dealdata;
Dim=139;%��������
out=randperm(Dim)';%��1-Dim�����ִ���
trainnum=69;%ѵ��������
validationnum=35;%��֤������
testnum=35;%���Լ�����
train=out(1:trainnum);
validation=out(trainnum+1:trainnum+validationnum);
test=out(trainnum+validationnum+1:Dim);
%��Ϊ��������֤
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
%���Ϸ���
%n��10


%% ��ʼ������:
Keygenenum=5;
Dim=120;%���ӵ�ά��,ѡȡ��lncRNA������
xSize=5;%��Ⱥ��  
MaxIt=10;%����������
c1=2;
c2=2;%�����������
w=0.8;%�����������
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
%%�����������λ��
v=rand(xSize,Dim);%���ӵĳ�ʼ�ٶ�
xbest=zeros(xSize,Dim);%�������ӵĳ�ʼ���λ��
fxbest=zeros(xSize,1);%xbest����Ӧ��
gbest=zeros(1,Dim);%����Ⱥ�ĳ�ʼ���λ��
fgbest=0;%gbest����Ӧ��
ybnum=trainnum;%��������
yznum=validationnum;%��֤����
csnum=testnum;%��������
%����Ⱥ����λ�ú͵�����������λ�õ�ѡ��
%% ����ѭ���㷨:
iter=0;
t1=clock;  
while iter<MaxIt
     LoadingTime=0;TrainingTime=0;TestingTime=0;TrainingAccuracy=0;TestingAccuracy=0;
    iter=iter+1;

     for xSizenum=1:xSize
    for i=1:ybnum
      train(i,1)=traindata(i,1);
    end
    %����ѵ������ʼ��
        for i=1:yznum
      validation(i,1)=validationdata(i,1);
    end
   %������֤����ʼ��
   for z=1:ybnum%1-43
           dimnum=1;
    for i=1:Dim%1-200
       if(x(xSizenum,i)==1)
            dimnum=dimnum+1;
           train(z,dimnum)=traindata(z,i+1);  
       end
    end
   end
    %����ѵ������ʼ��
    
   for z=1:yznum%1-20
           dimnum=1;
    for i=1:Dim%1-200
       if(x(xSizenum,i)==1)
            dimnum=dimnum+1;
           validation(z,dimnum)=validationdata(z,i+1);  
       end
    end
   end
  %������֤����ʼ��
    
    
   LoadingTime=0;TrainingTime=0;TestingTime=0;TrainingAccuracy=0;TestingAccuracy=0;
testsum=0;
for testx=1:10
   [LoadingTime,TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm(train, validation, 1,40,'sig');
   testsum=testsum+TestingAccuracy;
end
fx(xSizenum)=testsum;
 end
    %���elm
    %fx=elm����
  for i=1:xSize
      su=0;
      for sunum=1:Dim
      su=su+x(i,sunum);
      end
        if su>Keygenenum
            fx(i)=0;%����������Ʒ�������������ʱ,������Ӧ������Ϊ1
        end
  end
 
    for i=1:xSize
        if fxbest(i)<fx(i)
            fxbest(i)=fx(i);
            xbest(i,:)=x(i,:);%�����ӵ���Ӧ��fx(i)�����������Ӧ��ʱfxbest(i),�������ԭ�����ӵ������Ӧ��,�����´˽�
        end
    end
    if fgbest<max(fxbest)
        [fgbest,g]=max(fxbest);
        gbest=xbest(g,:);%���������ӵ������Ӧ��fxbest(g)������Ⱥ�������Ӧ��ʱ,�������ԭ����Ⱥ�������Ӧ��,�����´˽�
    end
       for i=1:ybnum
      lasttrain(i,1)=traindata(i,1);
    end
    %���ѵ����ʼ��
        for i=1:yznum
      lastvalidation(i,1)=validationdata(i,1);
        end
    %�����֤��ʼ��
        for i=1:yznum
      lastvalidation(i,1)=validationdata(i,1);
        end
    %�����֤��ʼ��
         for i=1:csnum
      lasttest(i,1)=testdata(i,1);
        end
    %��������ʼ��
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
            x(i,:)=round(rand(1,Dim));%Ϊ��ֹ�㷨����ֲ����ţ���ĳ�����ӵ�λ�õ�����Ⱥ���λ�ã����Ը����ӵ�λ�����³�ʼ����ֵ
        end
    end
    R1=rand(xSize,Dim);
    R2=rand(xSize,Dim); 
    v=v*w+c1*R1.*(xbest-x)+c2*R2.*(repmat(gbest,xSize,1)-x);%���ٶȵ�����ʽ�����µ��ٶ�
    x=x+v;%��������Ⱥ��λ��
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

    end%�������ӵ�λ��ֻ��(0,1)����״̬,�˴���0.5Ϊ�ֽ��Ժ���ֵ������ɢ��
    mygbest(iter)=fgbest;
    iter
    fgbest
 
end
t2=clock;
etime(t2,t1)  
%     for i=1:ybnum
%       lasttrain(i,1)=traindata(i,1);
%     end
%     %���ѵ����ʼ��
%         for i=1:yznum
%       lasttest(i,1)=testdata(i,1);
%         end
%     %�����Գ�ʼ��
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


            