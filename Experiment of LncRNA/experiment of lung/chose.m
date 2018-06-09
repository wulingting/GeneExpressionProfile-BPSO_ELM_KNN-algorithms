%preatrementdata informationgain
samplenumber=192;
lncrnanumber=231;
chosenumber=200;

data=Pretreatmentdata(2:lncrnanumber+1,2:samplenumber+1);

for i=1:samplenumber
     if i>=134 
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
     t(i)=i-1;%½«a¸Ä³Ét;
end
t=t';
dealdata=[t,dealdata];