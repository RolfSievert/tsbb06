load A
size(A)

[PC S] = svd(A);                  %Compute SVD of A
PM = diag(S);                     %magnitudes are given by the
                                  %singular values

figure(1);
subplot(2,1,1); plot(PM,'o');
subplot(2,1,2); plot(log(PM),'o');

% Question 1: 4

M = 4;
figure(2);plot(diff(PM((M + 1):end)),'o');

% Question 2: Yes

figure(3); 
plot(PC(:, 1)' * A, PC(:,2)'*A,'o'); % Project A on these two axis 
axis('equal');

% Question 3: Principal componnt 1 has much greater variance
m=mean(A,2);
A0 = A - m*ones(1,size(A,2));
[PC S] = svd(A0);
PM = diag(S);
figure(4);
subplot(2,1,1);plot(PM,'o');
subplot(2,1,2);plot(log(PM),'o');
figure(5);
subplot(4,1,1); plot(PC(:,1)'*A0, PC(:,2)'*A0,'o'); axis('equal')
subplot(4,1,2); plot(PC(:,2)'*A0, PC(:,3)'*A0,'o'); axis('equal')
subplot(4,1,3); plot(PC(:,3)'*A0, PC(:,4)'*A0,'o'); axis('equal')
subplot(4,1,4); plot(PC(:,4)'*A0, PC(:,5)'*A0,'o'); axis('equal')

%figure(6);plot(...,’o’);

% Question 4: 3, less than before

% Question 5: No. Removed a dimension by subtracting the mean
figure(7);
plot3(PC(:,1)'*A0, ...
      PC(:,2)'*A0, ...
      PC(:,3)'*A0, 'o'); axis('equal');
  
% Question 6: Normal?

% Question 7: Rolling a dice

mesh(A0);
imagesc(A0);

% Question 8: No

