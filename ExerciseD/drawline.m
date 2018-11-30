function drawline(l),

l=-l/norm(l(1:2))*sign(l(3));

y0=-l(1:2)*l(3);
y1=y0+1000*[l(2) -l(1)]';
y2=y0-1000*[l(2) -l(1)]';

plot([y1(1) y2(1)],[y1(2) y2(2)],'g');

return
