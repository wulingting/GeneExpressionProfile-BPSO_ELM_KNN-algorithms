%数组下标从1开始
%liver包含84个癌症样本，42个正常样本，共计126个样本数
%输入liver初始数据，去掉错误项
for i=1:235
   a(i)=i;    
end
%lncRNA数量
b(1)=0;
%样本分类1
for i=1:84
   b(i+1)=i;    
end
%样本分类2(normal)
for i=85:126
   b(i+1)=i;    
end
a=a';
Ratio=[a,Ratio];
Ratio=[b;Ratio];
for x=1:235
      zeronum(x)=0;
 end
%统计一下每个lncRNA所对应的ratio值为0的个数
for x=1:235
    for y=2:127
        if Ratio(x,y)==0
            zeronum(x)=zeronum(x)+1;
        end 
    end  
end
zero=0;
%统计有多少个不为0的
for x=1:235
      if zeronum(x)==0;
           zero=zero+1;
           zeroposition(zero)=x;
      end
end
%提取不包含任何ratio为0的lncRNA
 for x=1:zero
     Pretreatmentdata(x,:)=Ratio(zeroposition(x),:);
 end
%去掉包括0的lncrna

 for x=1:zero
     Pretreatmentdata(x,:)=Ratio(zeroposition(x),:);
 end
 save Pretreatmentdata;

            