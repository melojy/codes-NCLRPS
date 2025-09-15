function [P] = myPCA(Xtrain,d)

% Step 1
X_centered = double(Xtrain) - double(mean(Xtrain));

% Step 2
covariance_matrix = cov(X_centered);

% Step 3
[eigenvectors, eigenvalues] = eig(covariance_matrix);

% Step 4

[~, index] = sort(diag(eigenvalues), 'descend');
P = eigenvectors(:, index(1:d));
end

