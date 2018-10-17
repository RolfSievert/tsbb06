%% Init
addpath functions;

%%
n1 = [1 1 1]';
n1 = n1/norm(n1);
a = 0.1;

R1 = liu_rodrigues(n1, a);
% Question 1
disp(n1);
disp(R1*n1);

%%
[dir, angle] = get_rotation(R1);
% Question 2
disp(dir);
disp(angle);

%%
R2 = compute_R(dir, angle);
% Question 3
disp(R1);
disp(R2);

%%
[e1 l1] = eig(R1);
[e2 l2] = eig(a*liu_crossop(n1));

% TODO question 4...

%%
q = [n1(1)*sin(a/2); n1(2)*sin(a/2); n1(3)*sin(a/2); cos(a/2)];
disp(norm(q)); % Should be 1

x0 = randn(3, 1);
p = [0; x0];

% Question 5 TODO
disp(R1*x0);
disp(q.*p.*conj(q));

%%
% Question 6
disp(liu_R_from_q(q));
disp(R1);

%%
N = 9;
x1 = 2*rand(3, N) - 1;
%t = 2*rand(3, 1) - 1;
t = zeros(3, 1);
n = 2*rand(3, 1) - 1;
n = n/norm(n);
a = 2*pi*rand(1, 1);
R = liu_rodrigues(n, a);

x2 = R*x1+t*ones(1, N);
s = 0.0;
x1n = x1 + s*randn(3, N);
x2n = x2 + s*randn(3, N);

% 5.2
[Rest test] = est_rigid_transform(x1n, x2n);
% Question 7
disp(inv(Rest));
disp(Rest');
disp(det(Rest));
disp(R);

%% Question 8
x2e = Rest*x1n;%+ test*ones(1, N);
err = norm(x2e- x2n, 'fro');
disp(x2e);
disp(x2n);
disp(err);