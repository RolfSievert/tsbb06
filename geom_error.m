function e1 = geom_error(y1, y1b, y2, y2b)
    e1 = 0;
    for k = 1:length(y1)
        e1 = e1 + norm(vgg_get_nonhomg(y2(:,k)) - vgg_get_nonhomg(y2b(:,k)))^2 + ...
            + norm(vgg_get_nonhomg(y1(:,k)) - vgg_get_nonhomg(y1b(:,k)))^2;
    end
    e1 = sqrt(e1);
end

