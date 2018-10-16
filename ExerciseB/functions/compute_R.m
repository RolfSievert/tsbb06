function [R] = compute_R(dir, angle)
    % exmp removes scaling
    R = expm(liu_crossop(dir*angle));
end

