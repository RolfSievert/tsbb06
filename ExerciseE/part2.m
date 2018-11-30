im = double(imread('middlebury.png')); % Choose you image here!
size(im)
figure(10); colormap('gray');imagesc(im);

N = 8;
A = im2col(im,[N N],'distinct');
size(A)

PC = ...
PM = ...
figure(11);
subplot(2,1,1);plot(PM,'o');
subplot(2,1,2);plot(log(PM),'o');

figure(12);colormap('gray');
for M=1:6,
c=PC(:,1:M)'*A;    %Compute coordinates from blocks
Arec=PC(:,1:M)*c;  %Reconstruct blocks from coordinates
imrec=col2im(Arec,[N N],size(im),'distinct');  %Reshape into image
subplot(2,3,M);imagesc(imrec);axis('off');     %Display image
title(sprintf('%d principal components',M));   %Set title
end

% Question 9
% Question 10
% Question 11

figure(14);colormap('gray');
for cnt=1:6,
subplot(2,3,cnt);h=mesh(reshape(PC(:,cnt),N,N));
set(h,'edgecolor','black');axis([1 N 1 N -0.5 0.5]);
title(sprintf('principal component %d',cnt));
end

% Question 12
% Question 13
% Question 14
% Question 15
% Question 16
% Question 17

im = rand(512,512);

% Question 18
% Question 19
% Question 20