%preatrementdata informationgain
samplenumber=139;
lncrnanumber=124;
chosenumber=120;%在第一步筛选（包含0的去除）之后还剩下124个lncRNA，选取120个
data=Pretreatmentdata(2:lncrnanumber+1,2:samplenumber+1);

for i=1:samplenumber
     if i>=88 
         name(i,1)=1;
      else 
         name(i,1)=0;
     end
end

[Sortvalue,Sortposition]=sort(delta_Ib);
num=1;
for i=1:lncrnanumber
    if Sortposition(i)<chosenumber+1
        dealdata(num+1,:)=data(i,:);     
        num=num+1;     
    end
end

for i=1:samplenumber
       dealdata(1,i)=i;
end

for i=1:chosenumber+1
     t(i)=i-1;%将a改成t;
end
t=t';
dealdata=[t,dealdata];
save chose dealdata