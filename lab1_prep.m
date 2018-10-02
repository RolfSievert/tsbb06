y1=[1 2 3 4; 
    1 2 3 4; 
    1 1 1 1];
y2=[1 2 3 4;
    1 2 3 4;
    1 1 1 1];
A = [];

N = 4;
for k=1:N
    A = [A;
        [y1(1, k) 0 -y1(1, k)*y2(1, k) y1(2, k) 0 -y1(2, k)*y2(1, k) 1 0 -y2(1, k)];
        [0 y1(1, k) -y1(1, k)*y2(2, k) 0 y1(2, k) -y1(2, k)*y2(2, k) 0 1 -y2(2, k)]
        ]; % fill in first two equations
end

disp(A);

A1 = A(:,1:end - 1);
disp(A1);
a0=A(:,end);
disp(a0);


z=-inv(transpose(A1)*A1)*transpose(A1)*a0;