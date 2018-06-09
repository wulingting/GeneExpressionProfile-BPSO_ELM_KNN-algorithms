%输入Breast初始数据，去掉错误项
for i=1:580
   a(i)=i;    
end
%lncRNA数量
b(1)=0;
for i=1:90
   b(i+1)=i;    
end
%样本分类1
for i=91:201
   b(i+1)=i;    
end
%样本分类2
a=a';
StageIvsNormalRatio=[a,StageIvsNormalRatio];
StageIvsNormalRatio=[b;StageIvsNormalRatio];
for x=1:581
      zeronum(x)=0;
 end

for x=1:581
    for y=2:202
        if StageIvsNormalRatio(x,y)==0
            zeronum(x)=zeronum(x)+1;
        end 
    end  
end
zero=0;
for x=1:581
      if zeronum(x)==0;
           zero=zero+1;
           zeroposition(zero)=x;
      end
end

 for x=1:zero
     Pretreatmentdata(x,:)=StageIvsNormalRatio(zeroposition(x),:);
 end
%去掉包括0的lncrna

 for x=1:zero
     Pretreatmentdata(x,:)=StageIvsNormalRatio(zeroposition(x),:);
 end
 

            