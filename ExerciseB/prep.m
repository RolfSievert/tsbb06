%% Init
addpath functions;

%%
% 2
n1 = [1 1 1]';
n1 = n1/norm(n1);
a = 0.1;

R1 = liu_rodrigues(n1, a);

[dir, angle] = get_rotation(R1);
disp(dir);

R2 = compute_R(dir, angle);
disp(R1);
disp(R2);

[d2, a2] = get_rotation(R2);

[e1 l1] = eig(R1);
[e2 l2] = eig(a*liu_crossop(n1));