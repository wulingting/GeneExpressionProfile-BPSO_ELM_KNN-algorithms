%输入colon初始数据，去掉错误项
for i=1:440
   a(i)=i;    
end
%lncRNA数量
b(1)=0;
for i=1:74
   b(i+1)=i;    
end
%样本分类1
for i=75:114
   b(i+1)=i;    
end
%样本分类2
a=a';
	Ratio=[a,Ratio];
Ratio=[b;Ratio];
for x=1:440
      zeronum(x)=0;
 end

for x=1:440
    for y=2:115
        if Ratio(x,y)==0
            zeronum(x)=zeronum(x)+1;
        end 
    end  
end
zero=0;
for x=1:440
      if zeronum(x)==0;
           zero=zero+1;
           zeroposition(zero)=x;
      end
end

 for x=1:zero
     Pretreatmentdata(x,:)=Ratio(zeroposition(x),:);
 end
%去掉包括0的lncrna

 for x=1:zero
     Pretreatmentdata(x,:)=Ratio(zeroposition(x),:);
 end
 

            