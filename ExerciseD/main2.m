
load('tridata','x','y1','y2','im1','im2','C1','C2');

figure(1);image([im1 im2]);
colormap(gray(256));hold on;
for k=1:size(y1,2),
plot(y1(2,k),y1(1,k),'ro');
plot(y2(2,k)+size(im1,2),y2(1,k),'ro');
end
hold off;
%%
xrec=[];
for ix=1:length(y1),
recpoint = tri(y1(:,ix), y2(:,ix), C1, C2);
xrec=[xrec recpoint];
end

figure(3);plot3(xrec(1,:),xrec(2,:),xrec(3,:),'o');

%%

e = []

for i=1:length(x),
    e = [e sqrt(sum((x(:,i)-xrec(:,i)).^2))];
end

disp('Mean:');
mean(e)
disp('STD:');
std(e)

%%

y1e = C1*x;
y2e = C2*x;
e1 = [];
e2 = [];

for i=1:length(x),
    y1e_ = vgg_get_nonhomg(y1e);
    y2e_ = vgg_get_nonhomg(y2e);
    e1 = [e1 sqrt(sum((y1(1:2,i)-y1e_(:,i)).^2))];
    e2 = [e2 sqrt(sum((y2(1:2,i)-y2e_(:,i)).^2))];
end

disp('Mean 1:');
mean(e1)
disp('STD 1:');
std(e1)

disp('Mean 2:');
mean(e2)
disp('STD 2:');
std(e2)



