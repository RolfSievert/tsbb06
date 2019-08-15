function [H, A, z] = create_homog_2(y1, y2)
    A = [];
    N = size(y1, 2);
    for k=1:N
        A = [A;
             [y1(1, k) 0 -y1(1, k)*y2(1, k) y1(2, k) 0 -y1(2, k)*y2(1, k) 1 0 -y2(1, k)];
             [0 y1(1, k) -y1(1, k)*y2(2, k) 0 y1(2, k) -y1(2, k)*y2(2, k) 0 1 -y2(2, k)]
            ];

        A1 = A(:,2:end);
    end

    a0=A(:,1);

    z_hat=-inv(transpose(A1)*A1)*transpose(A1)*a0;
    z = [1; z_hat];

    H=reshape(z, 3, 3);
end