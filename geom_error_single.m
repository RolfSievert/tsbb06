function e1 = geom_error_single(y, yb)
    e1 = 0;
    for k = 1:length(y)
        e1 = e1 + norm(vgg_get_nonhomg(y(:,k)) - vgg_get_nonhomg(yb(:,k)))^2;
    end
    e1 = sqrt(e1);
end