function distortion = LoopZhangDistortion(e12,e21,w,h,lambda),

PPt=w*h*diag([w*w-1 h*h-1])/12;

pcpct=[(w-1)^2 (w-1)*(h-1);(w-1)*(h-1) (h-1)^2]/4;

temp=liu_crossop(e12);
e12cross=temp(1:2,1:2);
temp=liu_crossop(e21);
e21cross=temp(1:2,1:2);

A1=e12cross*PPt*e12cross;
B1=e12cross*pcpct*e12cross;
A2=e21cross*PPt*e21cross;
B2=e21cross*pcpct*e21cross;

Z=[lambda;ones(size(lambda))];

distortion=[];
for ix=1:length(lambda),
  z=Z(:,ix); 
  distortion=[distortion (z'*A1*z)/(z'*B1*z)+(z'*A2*z)/(z'*B2*z)];
end

return
