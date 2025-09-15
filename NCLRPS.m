function [P,W] = NCLRPS(Xtrain,alpha,beta,tol,D)
%outout£ºprojection matrix:P£¬appendix matrix:W.
%input£ºtrain matrix:Xtrain£¬low dimension:D, parameter:alpha£¬beta£¬tol.

[n,~]=size(Xtrain);
X=Xtrain';
P=myPCA(Xtrain,D);%initilaze P
[Re,~] = lKNN(Xtrain,2,2);
W=LKNN_W(Xtrain,Re);%initilize W
gamma2=1/n*(1-tol);
gamma1=tol/1-tol;
I=ones(n,1);
T1=0;

while T1<10
    
%% Z
d=diag(sum(W,2));
L=d-W;
Z=P'*X*pinv(gamma1*L+eye(n));

%% W
A=zeros(n,n);

for i=1:n
    
    for j=1:n
        
        A(i,j)=alpha*gamma1*norm(Z(:,i)-Z(:,j),2)^2;
        
    end
    
end

B1=-A/2*beta;
T2=0;

while T2<10
    
           C = B1+B1'/2;          
           W1 = C+((n+I'*C*I)*ones(n,n))/n^2-(C*ones(n,n)+ones(n,n)*C)/n;
           W1 = W1-diag(diag(W1));
           B2 = W1;
           W2 = max(B2,0); 
           B1 = W2;    
           T2 = T2+1;
           
end

%% P
d=diag(sum(W,2));
L=d-W;
M=X*((1-alpha*gamma2)*eye(n)-2*pinv(gamma1*L+eye(n))+pinv(gamma1*L+eye(n))*pinv(gamma1*L+eye(n)))*X';
[V2,SS2]=eig((M+M')/2);
SS2=diag(SS2);
[~,index2]=sort(SS2,'ascend'); 
V2=V2(:,index2); 
V2=real(V2);
P=V2(:,1:D);
T1=T1+1;

end
end
