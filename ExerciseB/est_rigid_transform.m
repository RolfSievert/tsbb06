function [R t] = est_rigid_transform(x1n, x2n)
    
    N = length(x1n(1,:));
    a0 = mean(x1n, 2);
    b0 = mean(x2n, 2);
    A = x1n - a0*ones(1, N);
    B = x2n - b0*ones(1, N);

    [U S VT] = svd(B*A');
    R = U*VT;
    
    if abs(det(R)-1) > 0.001 
        R = zeros(3, 3);
    end
    
    t = a0 - b0;
    
end