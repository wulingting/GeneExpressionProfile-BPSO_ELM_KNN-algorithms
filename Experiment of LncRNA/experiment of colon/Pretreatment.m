%����colon��ʼ���ݣ�ȥ��������
for i=1:440
   a(i)=i;    
end
%lncRNA����
b(1)=0;
for i=1:74
   b(i+1)=i;    
end
%��������1
for i=75:114
   b(i+1)=i;    
end
%��������2
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
%ȥ������0��lncrna

 for x=1:zero
     Pretreatmentdata(x,:)=Ratio(zeroposition(x),:);
 end
 

            