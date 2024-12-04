N=50;
theta=0.5:179;
p=75;
d=sqrt(2)*N;
%[A,b_exact,x_exact,theta,p,d] = paralleltomo(N,theta,p,d,1);
load("all.mat");
x_image=reshape(x_ex,N,N);
figure; 
imagesc(x_image),
colormap gray;

eta =.05; %0.1;%05;%01       % Relative noise level.
delta = eta*norm(b_ex);

% Add normally distributed pseudorandom noise to the right hand side / data (in our case, the blurred image).
%randn, by itself, returns a scalar whose value changes each time it's referenced.
rng('default')% rng  controls the random number generator used. Here, 'default' resets the generator to its initial state.
R = randn(size(b_ex));
e = delta*R/norm(R);
b = b_ex + e; %we add the noise to the right hand side (rhs)

figure;
picard(U,s,b);

rPicard=1650;
x_r = tsvd(U,s,V,b,rPicard);
figure;
imagesc(reshape(x_r,N,N)), colormap gray;
axis image off
%c = caxis;
title('TSVD r=400')

[x_lambda,rho,eta] = tikhonov(U,s,V,b,s(rPicard));

figure;
imagesc(reshape(x_lambda,N,N)), colormap gray;
axis image off
title('Tikhonov \lambda from Picard')

figure;
subplot(2,2,1)
imagesc(reshape(x_r,N,N)), colormap gray;
axis image off
title('TSVD r from Picard')
subplot(2,2,2)
imagesc(reshape(x_lambda,N,N)), colormap gray;
axis image off
title('Tikh. \lambda from Picard')
subplot(2,2,3.5)
imagesc(reshape(x_image,N,N)), colormap gray;
axis image off
title('Exact unknown image (x)')

xtik=reshape(x_lambda,N,N);
xtsvd=reshape(x_r,N,N);
e1=x_image-xtik;
e2=x_image-xtsvd;
errorTik=norm(e1,1)/2500
errorTsvd=norm(e2,1)/2500


eta =.01; %0.1;%05;%01       % Relative noise level.
delta = eta*norm(b_ex);

% Add normally distributed pseudorandom noise to the right hand side / data (in our case, the blurred image).
%randn, by itself, returns a scalar whose value changes each time it's referenced.
rng('default')% rng  controls the random number generator used. Here, 'default' resets the generator to its initial state.
R = randn(size(b_ex));
e = delta*R/norm(R);
b2 = b_ex + e; %we add the noise to the right hand side (rhs)

figure;
picard(U,s,b2);

rPicard2=1850;
x_r2 = tsvd(U,s,V,b2,rPicard2);
figure;
imagesc(reshape(x_r2,N,N)), colormap gray;
axis image off
%c = caxis;
title('TSVD r=1, noise=1%')

[x_lambda2,rho2,eta2] = tikhonov(U,s,V,b2,s(rPicard2));

figure;
imagesc(reshape(x_lambda2,N,N)), colormap gray;
axis image off
title('Tikhonov \lambda from Picard,noise=1%')

figure;
subplot(2,2,1)
imagesc(reshape(x_r2,N,N)), colormap gray;
axis image off
title('TSVD r from Picard,noise=1%')
subplot(2,2,2)
imagesc(reshape(x_lambda2,N,N)), colormap gray;
axis image off
title('Tikh. \lambda from Picard,noise=1%')
subplot(2,2,3.5)
imagesc(reshape(x_image,N,N)), colormap gray;
axis image off
title('Exact unknown image (x),noise=1%')

xtik2=reshape(x_lambda2,N,N);
xtsvd2=reshape(x_r2,N,N);
e12=x_image-xtik2;
e22=x_image-xtsvd2;
errorTik2=norm(e12,1)/2500
errorTsv2=norm(e22,1)/2500




figure;
picard(U,s,b_ex);

rPicard3=1950;
x_r3 = tsvd(U,s,V,b_ex,rPicard3);
figure;
imagesc(reshape(x_r3,N,N)), colormap gray;
axis image off
%c = caxis;
title('TSVD r=1, no noise')

[x_lambda3,rho3,eta3] = tikhonov(U,s,V,b_ex,s(rPicard3));

figure;
imagesc(reshape(x_lambda3,N,N)), colormap gray;
axis image off
title('Tikhonov \lambda from Picard,no noise')

figure;
subplot(2,2,1)
imagesc(reshape(x_r3,N,N)), colormap gray;
axis image off
title('TSVD r from Picard,no noise')
subplot(2,2,2)
imagesc(reshape(x_lambda3,N,N)), colormap gray;
axis image off
title('Tikh. \lambda from Picard,no noise')
subplot(2,2,3.5)
imagesc(reshape(x_image,N,N)), colormap gray;
axis image off
title('Exact unknown image (x),no noise')

xtik3=reshape(x_lambda3,N,N);
xtsvd3=reshape(x_r3,N,N);
e13=x_image-xtik3;
e23=x_image-xtsvd3;
errorTik3=norm(e13,1)/2500
errorTsv3=norm(e23,1)/2500


