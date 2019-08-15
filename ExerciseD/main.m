addpath dinoimages;

im1=imread('dinosaur0.png');
im2=imread('dinosaur5.png');
load('dino_Ps', 'P');
figure(1);image([im1 im2]);
C1=P{1};       % The camera matrix corresponding to image 1
C2=P{6};       % The camera matrix corresponding to image 2

e12 = C1*null(C2);
F12 = liu_crossop(e12)*C1*pinv(C2);
e21 = C2*null(C1);
F21 = liu_crossop(e21)*C2*pinv(C1);

%%
[y1_8, y2_8] = correspondences_select(im1, im2);
y1_8(end+1,:) = 1;
y2_8(end+1,:) = 1;
y1 = y1_8(:,1:5);
y2 = y2_8(:,1:5);
%%

disp(y2(:,3)'*F21*y1(:,3));

l2 = F21 * y1;
l1 = F21' * y2;
for ix=1:size(y1, 2),
    l1(:, ix) = -l1(:, ix) / norm(l1(1:2, ix)) * sign(l1(3, ix));
    l2(:, ix) = -l2(:, ix) / norm(l2(1:2, ix)) * sign(l2(3, ix));
end

e12n = vgg_get_nonhomg(e12);
e21n = vgg_get_nonhomg(e21);

figure(2); clf;
subplot(1,2,1); image(im1); hold on; plot(e12n(1,1),e12n(2,1),'r+');
subplot(1,2,2); image(im2); hold on; plot(e21n(1,1),e21n(2,1),'r+');
for k=1:size(y1,2),
    subplot(1,2,1); plot(y1(1,k),y1(2,k),'r*');drawline(l1(:,k));
    subplot(1,2,2); plot(y2(1,k),y2(2,k),'r*');drawline(l2(:,k));
end

%%
disp(abs(sum(y1.*l1)));
disp(abs(sum(y2.*l2)));
%%
disp(vgg_get_nonhomg(null(F21)));
disp(vgg_get_nonhomg(null(F21')));
%%
for k=2:size(y1,2),
    disp(vgg_get_nonhomg(cross(l1(:,1), l1(:,k))));
end  
%%

w=720; h=576; % Image width and height
lambda = -5:0.01:5; %Replace with the interval you choose
dist = LoopZhangDistortion(e12,e21,w,h,lambda);
figure(3);
plot(lambda,dist);
set(gca,'YScale','log');
grid on;
lmin = lambda(dist==min(dist));  %Print minimum lambda
disp(lmin);

%%

lambda = lmin;
w1 = liu_crossop(e12) * [lambda 1 0]';
w1 = w1 / w1(3);
w2=F21*[lambda 1 0]';
w2=w2/w2(3);
Hp1=[1 0 0;0 1 0;w1'];
Hp2=[1 0 0;0 1 0;w2'];

vcp=0;
Hr1= [
    F21(3,2)-w1(2)*F21(3,3) w1(1)*F21(3,3)-F21(3,1) 0;
    F21(3,1)-w1(1)*F21(3,3) F21(3,2)-w1(2)*F21(3,3) F21(3,3)+vcp;
    0 0 1 
];
Hr2=[
    w2(2)*F21(3,3)-F21(2,3) F21(1,3)-w2(1)*F21(3,3) 0;
    w2(1)*F21(3,3)-F21(1,3) w2(2)*F21(3,3)-F21(2,3) vcp;
    0 0 1
];

H1 = Hr1*Hp1;
H2 = Hr2*Hp2;

H1 = diag([-1 -1 1])*H1;
H2 = diag([-1 -1 1])*H2;

disp(inv(H1)'*F12*inv(H2));

%%

oldcorners=[1 w w 1;1 1 h h];
newcorners1=map_points(H1,oldcorners);
newcorners2=map_points(H2,oldcorners);
mincol=min([newcorners1(1,:) newcorners2(1,:)]);
minrow=min([newcorners1(2,:) newcorners2(2,:)]);
T=[1 0 -mincol+1;0 1 -minrow+1;0 0 1];
newcorners1=map_points(T*H1,oldcorners);
newcorners2=map_points(T*H2,oldcorners);
maxcol=max([newcorners1(1,:) newcorners2(1,:)]);
maxrow=max([newcorners1(2,:) newcorners2(2,:)]);
T=inv(diag([maxcol/w maxrow/h 1]))*T;

imr1=image_resample(double(im1),T*H1,h,w);
imr2=image_resample(double(im2),T*H2,h,w);
figure(4);image(uint8([imr1 imr2]));

y1r = map_points(T*H1,y1(1:2,:));
y2r = map_points(T*H2,y2(1:2,:));

figure(5); clf;
subplot(1,2,1); image(uint8(imr1)); hold on; plot(y1r(1,:),y1r(2,:),'r+');
subplot(1,2,2); image(uint8(imr2)); hold on; plot(y2r(1,:),y2r(2,:),'r+');

%% 12

F = fmatrix_n8pa(y1_8, y2_8);

F = F21

figure(1);clf;
subplot(1,2,1);image(im1);hold on;
subplot(1,2,2);image(im2);hold on;
l2=F*y1_8;
l1=F'*y2_8;
for k=1:size(y1_8,2),
l1(:,k)=-l1(:,k)/norm(l1(1:2,k))*sign(l1(3,k)); %Normalise dual
l2(:,k)=-l2(:,k)/norm(l2(1:2,k))*sign(l2(3,k)); %homog. coord.
end
for k=1:size(y1_8,2),
subplot(1,2,1);plot(y1_8(1,k),y1_8(2,k),'or');drawline(l1(:,k));
subplot(1,2,2);plot(y2_8(1,k),y2_8(2,k),'or');drawline(l2(:,k));
end
abs(sum(y1_8.*l1))
abs(sum(y2_8.*l2))

%%









