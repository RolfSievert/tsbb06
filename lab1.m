addpath graf;
addpath functions;

img1 = imread('img1.ppm');
img2 = imread('img2.ppm');

figure(1); imagesc(img1);
figure(2); imagesc(img2);

y1 = vgg_get_homg([528 223; 191 140; 154 556; 544 544;   688 114;  93 272; 317  29; 747 450]');
y2 = vgg_get_homg([450 242; 167 242; 266 633; 556 512;   531 119; 126 386; 234 115; 665 386]');
yy1 = y1(:,1:4);
yy2 = y2(:,1:4);

plot_points(1, y1);
plot_points(2, y2);

%%

[H1min, A0, z0] = create_homog(yy1, yy2);
disp(A0*z0);

%%

[H1, A, z] = create_homog(y1, y2);
y2b = H1*y1;
y1b = inv(H1)*y2;
plot_points(1, y1b);
plot_points(2, y2b);

%%

H1_e = geom_error(y1, y1b, y2, y2b);
disp(H1_e);
disp(geom_error_single(y1, y1b));
disp(geom_error_single(y2, y2b));

%%

img2t = uint8(image_resample(double(img1), H1, 640, 800));
figure(3); imagesc(img2t);

%%

figure(4); imagesc(img2t - img2);

%%

[H1_, A_, z_] = create_homog_2(y1, y2);
disp(A*z);
disp(A_*z_);
y2b_ = H1_*y1;
y1b_ = inv(H1_)*y2;
disp(geom_error(y1, y1b_, y2, y2b_));


%%

[U S V] = svd(A);
H2 = reshape(V(:,end),3,3);

[U0 S0 V0] = svd(A0);
H2_0 = reshape(V0(:,end),3,3);
disp(H1min);
disp(H2_0);

%%

y2b2 = H2*y1;
y1b2 = inv(H2)*y2;
H2_e = geom_error(y1, y1b2, y2, y2b2);
disp(H2_e);

%%

disp(diag(S)');
figure(4); plot(log(diag(S)), 'o');

%%

[y1tilde, T1] = liu_preconditioning(y1);
[y2tilde, T2] = liu_preconditioning(y2);

disp(sum(y1tilde, 2));
disp(sum(y2tilde, 2));
disp(avg_dist(y1tilde));
disp(avg_dist(y2tilde));

%%

[x1, Atilde, x2] = create_homog(y1tilde, y2tilde);

[Utilde, Stilde, Vtilde] = svd(Atilde);
Htilde = reshape(Vtilde(:,end), 3, 3);

H3 = inv(T2)*Htilde*T1;

%%

disp(diag(Stilde)')
figure(5); plot(log(diag(Stilde)),'o');

%%

y2b3 = H3*y1;
y1b3 = inv(H3)*y2;
H3_e = geom_error(y1, y1b3, y2, y2b3);
disp(H3_e);

%%

load -ascii H1to2p

y2bp = H1to2p*y1;
y1bp = inv(H1to2p)*y2;
disp(geom_error(y1b, y1bp, y2b, y2bp));
disp(geom_error(y1b2, y1bp, y2b2, y2bp));
disp(geom_error(y1b3, y1bp, y2b3, y2bp));

%%
l1 = cross(y1(:,1), y1(:,2));
figure(1);drawline(l1,'axis','xy');

l2 = inv(H3')*l1;
figure(2);drawline(l2,'axis','xy');

%%

figure(1); imagesc(img1);
figure(2); imagesc(img2);

y1d = vgg_get_homg([ 146 523; 218 519; 267 518; 324 514; 507 509 ]');
y2d = vgg_get_homg([ 246 605; 304 580; 342 566; 386 546; 520 493 ]');

plot_points(1, y1d);
plot_points(2, y2d);

%%

[Hd, Ad, zd] = create_homog(y1d, y2d);
[Ud Sd Vd] = svd(Ad);
Hd = reshape(Vd(:,end),3,3);

disp(diag(S)');
disp(Hd);
figure(4); plot(log(diag(S)), 'o');

%%

[y1dtilde, T1d] = liu_preconditioning(y1d);
[y2dtilde, T2d] = liu_preconditioning(y2d);

[Hdtilde, Adtilde, zdtilde] = create_homog(y1dtilde, y2dtilde);
[Udtilde Sdtilde Vdtilde] = svd(Adtilde);
Hdtilde = reshape(Vdtilde(:,end),3,3);

Hd_n = inv(T2d)*Hdtilde*T1d;

disp(diag(Sdtilde)');
disp(Hd_n);
figure(6); plot(log(diag(Sdtilde)), 'o');

%%


figure(7); imagesc(uint8(image_resample(double(img1), Hd, 640, 800)));
figure(8); imagesc(uint8(image_resample(double(img1), Hd_n, 640, 800)));





