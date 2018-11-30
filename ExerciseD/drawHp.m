function drawHp(e12,e21,w,h,lambda),

PPt=w*h*diag([w*w-1 h*h-1])/12;

pcpct=[(w-1)^2 (w-1)*(h-1);(w-1)*(h-1) (h-1)^2]/4;

temp=Hcross(e12);
e12cross=temp(1:2,1:2);
temp=Hcross(e21);
e21cross=temp(1:2,1:2);

A1=e12cross*PPt*e12cross;
B1=e12cross*pcpct*e12cross;
A2=e21cross*PPt*e21cross;
B2=e21cross*pcpct*e21cross;

Z=[lambda;ones(size(lambda))];

epsilon=[];
for ix=1:length(lambda),
  z=Z(:,ix); 
  epsilon=[epsilon (z'*A1*z)/(z'*B1*z)+(z'*A2*z)/(z'*B2*z)];
end

figure;plot(lambda,epsilon);
figure;plot(lambda(1:(end-1)),diff(epsilon));

return
