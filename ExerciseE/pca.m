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

