function [dir,angle] = get_rotation(R)
%GET_ROTATION Summary of this function goes here
%   Detailed explanation goes here

    v = liu_crossop(R);
    c = (trace(R) - 1)/2;
    s = norm(v);

    if s==0 then
        if c>0 then
            dir = [1 0 0]';
            angle = 0;
        else
            n = [];
            for k=1:3
                T = R + eye(3);
                n(:,k) = T(:,k);
            end
            max_norm = norm(n(1));
            max_k = 1;
            for k=2:3
                if norm(n(k)) > max_norm then
                    max_norm = norm(n(k));
                    max_k = k;
                end
            end
            dir = n(max_k)/max_norm;
            angle=pi;
        end
    else
        dir = v/s;
        angle = atan2(s, c);
    end
end

