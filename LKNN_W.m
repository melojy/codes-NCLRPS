function [S] = LKNN_W(Xtrain,Re)
%input: Xtrain training matrix£¬Re in lKNN.m
%output: adjacency mateix S

n=size(Xtrain,1);
S=zeros(n,n);
d=zeros(n,1);

for i=1:n
    
    [e] =KNN(Xtrain(i,:),Xtrain,7);
    d(i)=norm(Xtrain(i,:)-Xtrain(e(7),:));

end

for i=1:n
    
    for j=1:n

        [index,~]=ismember(Xtrain(j,:),Re{1,i},'rows');
        
        if index==0 
            S(i,j)=0;
            
        else 
            
            S(i,j)=exp((-norm(Xtrain(i,:)-Xtrain(j,:))/(d(i)*d(j))));
            
        end
        
    end
    
end

for i=1:n
    for  j=1:n
        if  S(i,j)==0&&S(j,i)~=0
            S(i,j)=S(j,i);
        end
    end
end

