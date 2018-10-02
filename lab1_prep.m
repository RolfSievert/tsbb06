%% Load functions
addpath functions;

%%
% radmatris
y1=vgg_get_homg([
 1123 22 343 455;
 145 245 3456 4345;
]);

y2=vgg_get_homg([
 20 40 60 90;
 30 30 70 70;
]);

A = [];

N = size(y1, 2);
for k=1:N
    A = [A;
        [y1(1, k) 0 -y1(1, k)*y2(1, k) y1(2, k) 0 -y1(2, k)*y2(1, k) 1 0 -y2(1, k)];
        [0 y1(1, k) -y1(1, k)*y2(2, k) 0 y1(2, k) -y1(2, k)*y2(2, k) 0 1 -y2(2, k)]
        ];
end

A1 = A(:,1:end - 1);
a0=A(:,end);

disp(transpose(A1)*A1);
z_hat=-inv(transpose(A1)*A1)*transpose(A1)*a0;
z = [z_hat; 1];

H1=reshape(z, 3, 3);

disp(vgg_get_nonhomg(H1*y1));