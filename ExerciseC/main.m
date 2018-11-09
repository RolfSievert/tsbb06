k = 0:1:100;
s = sin(k/10);
figure(1);plot(s);

x=(-3:3)';
b0=ones(7,1);
b1=x;
b2=x.^2;
figure(2);
subplot(4, 1, 1); plot(b0, '-o');
subplot(4, 1, 2); plot(b1, '-o');
subplot(4, 1, 3); plot(b2, '-o');

a = exp(-x.^2/4);
figure(2);
subplot(4, 1, 4); plot(a, '-o');

f0 = b0.*a; f0 = f0(end:-1:1);
f1 = b1.*a; f1 = f1(end:-1:1);
f2 = b2.*a; f2 = f2(end:-1:1);
figure(3);
subplot(3, 1, 1); plot(f0, '-o');
subplot(3, 1, 2); plot(f1, '-o');
subplot(3, 1, 3); plot(f2, '-o');

h0 = conv(s, f0, 'same');
h1 = conv(s, f1, 'same');
h2 = conv(s, f2, 'same');

G0 = diag(a);
B = [b0 b1 b2];
G = B'*G0*B;

% Question 1: No? Not normalized

%%
c = inv(G)*[h0; h1; h2];
figure(4);
subplot(3, 1, 1); plot(c(1,:));
subplot(3, 1, 2); plot(c(2,:));
subplot(3, 1, 3); plot(c(3,:));

% Question 2: Yes? The derevatives look good.

%%
figure(5);
localsig=s(60-3:60+3);
reconsig=(B*c(:,60))';
diffsig=localsig-reconsig;
subplot(3, 1, 1); plot(localsig);
subplot(3, 1, 2); plot(reconsig);
subplot(3, 1, 3); plot(diffsig);

% Question 3: Very similiar. 

%%
cert = double(rand(1, 101)>0.2);
scert = s.*cert;
figure(6); plot(scert);

% Question 4: It is partially zero. scert is isch 80 percent ones, rest
% being zeros. 

%%
h0 = conv(scert, f0, 'same');
h1 = conv(scert, f1, 'same');

% Fill in these!!!
G11 = conv(); 
G12 = conv();
G13 = conv();

detG = G11.*G22-G12.^2;
c0 = (G22.*ho-G12.*h1)./detG;
c1 = (-G12.*ho+G11.*h1)./detG; figure(7);
subplot(2, 1, 1); plot(c0);
subplot(2, 1, 2); plot(c1);

% Question 5: No idea.

% Question 6: No idea

% Question 7: No idea.

% Question 8: No idea.

%% Normalized averaging of images
im = double(imread('Scalespace0.png'));
figure(8); colormap(gray); imagesc(im);

cert = double(rand(size(im)) > 0.6); imcert = im.*cert;
figure(9); colormap(gray); imagesc(imcert);

x = ones(7, 1)*(-3:3);
y = x';
a = exp(-(x.^2+y.^2)/4);
figure(10); mesh(a);

imlp = conv2(imcert, a, 'same');
figure(11); colormap(gray); imagesc(imlp);

% Question 9: Blah.

%%

G = 0; % <---- Fill in this one!!
c = imlp./G;
figure(12);colormap(gray);imagesc(c);

% Question 10: Bleh

% Question 11

% Question 12

% Question 13

% Question 14