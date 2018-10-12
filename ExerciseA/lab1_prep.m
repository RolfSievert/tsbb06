%% Load functions
addpath functions;

%%
% radmatris
y1=vgg_get_homg([
 1100 220 340 455;
 145 245 3456 4345;
]);

y2=vgg_get_homg([
 1100 220 340 455;
 145 245 3456 4345;
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

%% Task 8
diff = vgg_get_nonhomg(H1 * y1) - vgg_get_nonhomg(y2);
%diff = vgg_get_nonhomg(H1\y2) - vgg_get_nonhomg(y1);
%no_homo_diff = vgg_get_nonhomg(diff);
%disp(diff);
normal = [];
for k=1:length(diff)
    normal = [normal norm(diff(:, k))];
end
%normal = norm(diff(:, 1));
distance=[diff; normal];
disp(distance);