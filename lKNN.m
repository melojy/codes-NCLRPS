function [Re,Su] = lKNN(Xtrain,k,l)
%output;Re is the nearest neighbors£¬Su is the index of Re
%input£ºparameter:k£¬l, training matrix Xtrain

[n,~]=size(Xtrain);

for i1=1:n
[e1] =KNN(Xtrain(i1,:),Xtrain,k);
Xk=Xtrain(e1,:);
j=1;

while j<l
    
    for i2=1:size(Xk,1)
        
        [e2]=KNN(Xk(i2,:),Xtrain,k);
        kNeighbors=Xtrain(e2,:);
        Xk=[Xk;kNeighbors];
        Xk=unique(Xk,'row');
        e1=[e1;e2];
        e1=unique(e1);
        
    end
    
    j=j+1;
    
end

Re{1,i1}=Xk;
Su{1,i1}=e1;

end
end

