%function F=fmatrix_nn8pa(y1,y2)
%
% Estimate a fundamental matrix F that relates y1 to y2 using the
% NON-normalized eight point algorithm.
%  i.e. y2'*F*y1=0
%
% 1. Estimate F
% 2. Enforce rank 2
%
% Y2, Y1  Homogeneous image coordinate lists (size 3xN)
%         which are normalized such that the third row is = 1.
%
%Per-Erik Forssen, Oct 2003

function F=fmatrix_nn8pa(y1,y2)

N=size(y1,2);

% Generate scaling homographies S

A=zeros(N,9);
for k=1:N,
  A(k,:)=reshape(y2(:,k)*y1(:,k)',1,9);
end

[U S V]=svd(A);
fprintf('Singular values of data matrix:\n');
format long
diag(S)'
format short

F=reshape(V(:,end),3,3);

[Uf Sf Vf]=svd(F);
S0=Sf;
S0(3,3)=0;
F0=Uf*S0*Vf';

F=F0;
