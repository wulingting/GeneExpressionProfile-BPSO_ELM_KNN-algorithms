%����Breast��ʼ���ݣ�ȥ��������
for i=1:580
   a(i)=i;    
end
%lncRNA����
b(1)=0;
for i=1:90
   b(i+1)=i;    
end
%��������1
for i=91:201
   b(i+1)=i;    
end
%��������2
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
%ȥ������0��lncrna

 for x=1:zero
     Pretreatmentdata(x,:)=StageIvsNormalRatio(zeroposition(x),:);
 end
 

            