%function F=fmatrix_n8pa(y1,y2)
%
% Estimate a fundamental matrix F that relates y1 to y2 using the
% normalized eight point algorithm.
%  i.e. y2'*F*y1=0
%
% 1. Scale data with Hartley normalization
% 2. Estimate F
% 3. Enforce rank 2
% 4. Apply scaling to F
%
% Y2, Y1  Homogeneous image coordinate lists (size 3xN)
%         which are normalized such that the third row is = 1.
%
%Per-Erik Forssen, Oct 2003

function F=fmatrix_n8pa(y1,y2)

N=size(y1,2);

% Generate scaling homographies S
y1m = mean(y1,2);
l = sqrt(1/2/N*sum(sum((y1-y1m*ones(1,N)).^2)));
S1 = [1/l  0  -y1m(1)/l;
      0   1/l -y1m(2)/l;
      0    0         1];

y2m = mean(y2,2);
l = sqrt(1/2/N*sum(sum((y2-y2m*ones(1,N)).^2)));
S2 = [1/l  0  -y2m(1)/l;
      0   1/l -y2m(2)/l;
      0    0         1];

% Map points
y1t = S1*y1;
y2t = S2*y2;
% Last row of S is [0 0 1], so h=1

A=zeros(N,9);
for k=1:N,
  A(k,:)=reshape(y2t(:,k)*y1t(:,k)',1,9);
end

[U S V]=svd(A);
fprintf('Singular values of data matrix:\n');
diag(S)'

F=reshape(V(:,end),3,3);

[Uf Sf Vf]=svd(F);
S0=Sf;
S0(3,3)=0;
F0=Uf*S0*Vf';

F=S2'*F0*S1;
