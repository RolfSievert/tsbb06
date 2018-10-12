function [R] = compute_R(dir, angle)
%COMPUTE_R Summary of this function goes here
%   Detailed explanation goes here
    R = exp(liu_crossop(dir*angle));

end

