%计算信息增益率
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
% Ni代表矩阵patterns的行（lncRNA数量），L代表矩阵的列（样本数量）
[Ni, L]		= size(patterns);
Nu          = 14;
discrete_dim = zeros(1,Ni);%创建1行Ni列的0矩阵
for i = 1:Ni,
    Ub = unique(patterns(i,:));
    Nb = length(Ub);
    if (Nb <= Nu),
        %This is a discrete pattern
        discrete_dim(i)	= Nb;
    end
end
%Build a tree recursively 递归构建树
%  patterns     - Train patterns,训练集D (the number of features) * (the number of samples)
%  targets	    - Train targets, 1*(the number of samples)训练集D的类数
%  inc_node     - Stop building a subtree if its total samples are less than inc_node，
%  discrete_dim - 1*(the number of features). 0 entries for continuous features 
%[Ni,L]= size(patterns);%Ni-the number of features，L-the number of samples）
Uc= unique(targets);%训练集D的类数，并从小到大排序
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
    data	= patterns(i,:);%第i个特征向量
    Ud      = unique(data);%第i个特征向量的取值空间。
    Nbins	= length(Ud);
    if (discrete_dim(i)),
        %This is a discrete pattern
        P	= zeros(length(Uc), Nbins);
        for j = 1:length(Uc),
            for k = 1:Nbins,
                indices 	= find((targets == Uc(j)) & (patterns(i,:) == Ud(k)));%  Dik  子集Di中属于类Ck的集合
                P(j,k) 	= length(indices);%Dik的长度
            end
        end
        Pk          = sum(P);%Di的样本个数
        P           = P./(eps+repmat(Pk,size(P,1),1)); 
        Pk          = Pk/sum(Pk);
        info        = sum(-P.*log(eps+P)/log(2));
        delta_Ib(i) = (Inode-sum(Pk.*info))/-sum(Pk.*log(eps+Pk)/log(2));%增益比
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

