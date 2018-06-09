%������Ϣ������
samplenumber=114;
lncrnanumber=179;
chosenumber=160;

data=Pretreatmentdata(2:lncrnanumber+1,2:samplenumber+1);

for i=1:samplenumber
     if i>=75 
       name(i,1)=1;
      else 
           name(i,1)=0;
     end
end

patterns=data;
targets=name;
disp(patterns);
disp(targets);
% Ni�������patterns���У�lncRNA��������L���������У�����������
[Ni, L]		= size(patterns);
Nu          = 14;
discrete_dim = zeros(1,Ni);%����1��Ni�е�0����
for i = 1:Ni,
    Ub = unique(patterns(i,:));
    Nb = length(Ub);
    if (Nb <= Nu),
        %This is a discrete pattern
        discrete_dim(i)	= Nb;
    end
end
%Build a tree recursively �ݹ鹹����
%  patterns     - Train patterns,ѵ����D (the number of features) * (the number of samples)
%  targets	    - Train targets, 1*(the number of samples)ѵ����D������
%  inc_node     - Stop building a subtree if its total samples are less than inc_node��
%  discrete_dim - 1*(the number of features). 0 entries for continuous features 
%[Ni,L]= size(patterns);%Ni-the number of features��L-the number of samples��
Uc= unique(targets);%ѵ����D������������С��������
disp(Uc);
for i = 1:length(Uc),
    Pnode(i) = length(find(targets == Uc(i))) / L;
    %disp(find(targets == Uc(i)));
end
Inode = -sum(Pnode.*log(Pnode)/log(2));

%For each dimension, compute the gain ratio impurity
%This is done separately for discrete and continuous patterns
delta_Ib    = zeros(1, Ni);
split_loc	= ones(1, Ni)*inf;

for i = 1:Ni,
    data	= patterns(i,:);%��i����������
    Ud      = unique(data);%��i������������ȡֵ�ռ䡣
    Nbins	= length(Ud);
    if (discrete_dim(i)),
        %This is a discrete pattern
        P	= zeros(length(Uc), Nbins);
        for j = 1:length(Uc),
            for k = 1:Nbins,
                indices 	= find((targets == Uc(j)) & (patterns(i,:) == Ud(k)));%  Dik  �Ӽ�Di��������Ck�ļ���
                P(j,k) 	= length(indices);%Dik�ĳ���
            end
        end
        Pk          = sum(P);%Di����������
        P           = P./(eps+repmat(Pk,size(P,1),1)); 
        Pk          = Pk/sum(Pk);
        info        = sum(-P.*log(eps+P)/log(2));
        delta_Ib(i) = (Inode-sum(Pk.*info))/-sum(Pk.*log(eps+Pk)/log(2));%�����
       tree(i)=delta_Ib(i);
       % disp(delta_Ib(i));
    else
        %This is a continuous patte
        P	= zeros(length(Uc), 2);

        %Sort the patterns
        [sorted_data, indices] = sort(data);
        sorted_targets = targets(indices);
        
        %Calculate the information for each possible split
        I	= zeros(1, L-1);
        for j = 1:L-1,
            for k =1:length(Uc),
                P(k,1) = length(find(sorted_targets(1:j) 	 == Uc(k)));
                P(k,2) = length(find(sorted_targets(j+1:end) == Uc(k)));
            end
            Pk      = sum(P); 
            P       = P./(eps+repmat(Pk,size(P,1),1)); 
            Pk      = Pk/sum(Pk);
            info	= sum(-P.*log(eps+P)/log(2)); 
            I(j)	= (Inode-sum(Pk.*info))/-sum(Pk.*log(eps+Pk)/log(2)); 
            %disp( I(j));
        end
        [delta_Ib(i), s] = max(I);
        split_loc(i) = sorted_data(s); %<=threshold vs. >threshold
    end
end 

