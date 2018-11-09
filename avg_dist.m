function avg = avg_dist(y)
    avg = 0;
    N = length(y);
    for k = 1:N
        avg = avg + norm(y(1:2,k));
    end;
    avg = avg/N;
end

