
%% Normalized averaging of images
im = double(imread('Scalespace0.png'));
figure(8); colormap(gray); imagesc(im);

cert = double(rand(size(im)) > 0.90); imcert = im.*cert;
figure(9); colormap(gray); imagesc(imcert);

x = ones(13, 1)*(-6:6);
y = x';
a = exp(-(x.^2+y.^2)/12);
figure(10); mesh(a);

imlp = conv2(imcert, a, 'same');
figure(11); colormap(gray); imagesc(imlp);

% Question 9: Blah.

G = conv2(cert, a, 'same');
c = imlp./G;
figure(12);colormap(gray);imagesc(c);
figure(13);colormap(gray);imagesc(G);

% Question 10: Bleh

% Question 11

% Question 12

% Question 13

% Question 14
