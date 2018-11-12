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

figure(13);
subplot(3, 1, 1); plot(h0, '-o');
subplot(3, 1, 2); plot(h1, '-o');
subplot(3, 1, 3); plot(h2, '-o');

G0 = diag(a);
B = [b0 b1 b2];
G = B'*G0*B;

% Question 1: No!
disp('Question 1:');
disp(G'*G);

%%
c = inv(G)*[h0; h1; h2];
figure(4);
subplot(3, 1, 1); plot(c(1,:));
subplot(3, 1, 2); plot(c(2,:));
subplot(3, 1, 3); plot(c(3,:));

% Question 2: Yes? They look like the derivitives of sin.

%% Prep 3
cp = inv(G);

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
cert = double(rand(1, 101)>0.3);
scert = s.*cert;
figure(6); plot(scert);

h0c = conv(scert, f0, 'same');
h1c = conv(scert, f1, 'same');
h2c = conv(scert, f2, 'same');

figure(14);
subplot(3, 1, 1); plot(h0c, '-o');
subplot(3, 1, 2); plot(h1c, '-o');
subplot(3, 1, 3); plot(h2c, '-o');

cc = inv(G)*[h0c; h1c; h2c];
figure(15);
subplot(3, 1, 1); plot(cc(1,:));
subplot(3, 1, 2); plot(cc(2,:));
subplot(3, 1, 3); plot(cc(3,:));

figure(16);
localsigc=s(60-3:60+3);
reconsigc=(B*cc(:,60))';
diffsigc=localsigc-reconsigc;
subplot(3, 1, 1); plot(localsigc);
subplot(3, 1, 2); plot(reconsigc);
subplot(3, 1, 3); plot(diffsigc);

% Question 4


%%
h0 = conv(scert, f0, 'same');
h1 = conv(scert, f1, 'same');

figure(17);
subplot(2, 1, 1); plot(h0);
subplot(2, 1, 2); plot(h1);

% Fill in these!!!
G11 = conv(cert, f0, 'same'); 
G12 = conv(cert, f1, 'same');
G22 = conv(cert, f0, 'same');

detG = G11.*G22-G12.^2;
c0 = (G22.*h0-G12.*h1)./detG;
c1 = (-G12.*h0+G11.*h1)./detG;

figure(7);
subplot(2, 2, 1); plot(c0);
subplot(2, 2, 3); plot(c1);
subplot(2, 2, 2); plot(cc(1,:));
subplot(2, 2, 4); plot(cc(2,:));

% Question 5: No idea.

% Question 6: Smooooth.

% Question 7: No idea.

% Question 8: No idea.

