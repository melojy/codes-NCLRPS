function [e] =KNN(in,test,k)
    dist=zeros(size(test,1),1);
for i=1:size(test,1)
     dist(i)=norm(in-test(i,:),2);
end   
    [~,index]=sort(dist);
     e=index(2:k+1);
end