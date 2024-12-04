%Initial parameters
N=50;
theta= 0.5:179;
p=75;
d = sqrt(2)*N;
load('all.mat');

x_image = reshape(x_ex, N, N);
figure; imagesc(x_image),colormap gray;

figure;
picard(U,s,b_ex);
title('Picard noise free')

rPicard0=1950;
x_r0 = tsvd(U,s,V,b_ex,rPicard0);
figure;
imagesc(reshape(x_r0,N,N)), colormap gray;
axis image off
title('TSVD r=1950 noise free')

[x_lambda0,rho0,eta0] = tikhonov(U,s,V,b_ex,s(rPicard0));
figure;
imagesc(reshape(x_lambda0,N,N)), colormap gray;
axis image off
title('Tikhonov \lambda from Picard noise free')

%Noise 1%
eta =.01; 
delta = eta*norm(b_ex);
rng('default')
R = randn(size(b_ex));
e = delta*R/norm(R);
b = b_ex + e; 

figure;
picard(U,s,b);
title('Picard 1% noise')

rPicard=1850;
x_r = tsvd(U,s,V,b,rPicard);
figure;
imagesc(reshape(x_r,N,N)), colormap gray;
axis image off
title('TSVD r=1650 1% noise')

[x_lambda,rho,eta] = tikhonov(U,s,V,b,s(rPicard));
figure;
imagesc(reshape(x_lambda,N,N)), colormap gray;
axis image off
title('Tikhonov \lambda from Picard 1% noise')

%Noise 5%
eta2 =.05; 
delta2 = eta2*norm(b_ex);
rng('default')
R2 = randn(size(b_ex));
e2 = delta2*R2/norm(R2);
b2 = b_ex + e2; 

figure;
picard(U,s,b2);
title('Picard 5% noise')

rPicard2=1650;
x_r2 = tsvd(U,s,V,b2,rPicard2);
figure;
imagesc(reshape(x_r2,N,N)), colormap gray;
axis image off
title('TSVD r=1550 5% noise')

[x_lambda2,rho2,eta2] = tikhonov(U,s,V,b2,s(rPicard2));
figure;
imagesc(reshape(x_lambda2,N,N)), colormap gray;
axis image off
title('Tikhonov \lambda from Picard 5% noise')


xtik0 = reshape(x_lambda0, N, N);
xtsvd0 = reshape(x_r0, N, N);
err0_1 = x_image - xtik0;
err0_2 = x_image - xtsvd0;
errortik0 = norm(err0_1,1)/2500
errortsvd0 = norm(err0_2,1)/2500

xtik1 = reshape(x_lambda, N, N);
xtsvd1 = reshape(x_r, N, N);
err1_1 = x_image - xtik1;
err1_2 = x_image - xtsvd1;
errortik1= norm(err1_1,1)/2500
errortsvd1= norm(err1_2,1)/2500

xtik2 = reshape(x_lambda2, N, N);
xtsvd2 = reshape(x_r2, N, N);
err2_1 = x_image - xtik2;
err2_2 = x_image - xtsvd2;
errortik2= norm(err2_1,1)/2500
errortsvd2= norm(err2_2,1)/2500