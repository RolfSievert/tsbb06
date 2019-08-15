function plot_points(fig, homg_p)
    p = vgg_get_nonhomg(homg_p);
    figure(fig); hold('on'); plot(p(1,:),p(2,:),'go');
end