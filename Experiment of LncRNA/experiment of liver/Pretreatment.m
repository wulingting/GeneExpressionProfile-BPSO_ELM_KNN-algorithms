%�����±��1��ʼ
%liver����84����֢������42����������������126��������
%����liver��ʼ���ݣ�ȥ��������
for i=1:235
   a(i)=i;    
end
%lncRNA����
b(1)=0;
%��������1
for i=1:84
   b(i+1)=i;    
end
%��������2(normal)
for i=85:126
   b(i+1)=i;    
end
a=a';
Ratio=[a,Ratio];
Ratio=[b;Ratio];
for x=1:235
      zeronum(x)=0;
 end
%ͳ��һ��ÿ��lncRNA����Ӧ��ratioֵΪ0�ĸ���
for x=1:235
    for y=2:127
        if Ratio(x,y)==0
            zeronum(x)=zeronum(x)+1;
        end 
    end  
end
zero=0;
%ͳ���ж��ٸ���Ϊ0��
for x=1:235
      if zeronum(x)==0;
           zero=zero+1;
           zeroposition(zero)=x;
      end
end
%��ȡ�������κ�ratioΪ0��lncRNA
 for x=1:zero
     Pretreatmentdata(x,:)=Ratio(zeroposition(x),:);
 end
%ȥ������0��lncrna

 for x=1:zero
     Pretreatmentdata(x,:)=Ratio(zeroposition(x),:);
 end
 save Pretreatmentdata;

            