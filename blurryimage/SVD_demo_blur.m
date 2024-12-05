%MAIN
%JCHS 12/2023, modified 09/2024

%Remember to set the path

%Read the image
x = imread('baboon.png'); %we read the 256x256 gray-scale image
%x = imread('cameraman.tif');
x=double(x);       % we convdert the image to double precision
x=imresize(x,0.2); %To avoid dealing with computer expense difficulties, we downsize the image 
                   % to a lower size (60% its original size).
%x=imresize(x,[128 128]);% resize to 128x128 gray-scale image
N=size(x,1)      % we keep in the variable 
figure; imagesc(x),colormap gray;

        
%We create the blurred image
[A,b_ex]=blursquareImage(N,x); %we call the function that creates our forward problem
figure;
subplot(1,2,1)
imagesc(x),colormap gray; title('Image')
axis image off
subplot (1,2,2)
imagesc(reshape(b_ex,N,N)),colormap gray; title('Blurred image')
axis image off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We introduce noise in the right hand side of our linear system (in the data)
eta =.05; %0.1;%05;%01       % Relative noise level.
delta = eta*norm(b_ex);

% Add normally distributed pseudorandom noise to the right hand side / data (in our case, the blurred image).
%randn, by itself, returns a scalar whose value changes each time it's referenced.
rng('default')% rng  controls the random number generator used. Here, 'default' resets the generator to its initial state.
R = randn(size(b_ex));
e = delta*R/norm(R);
b = b_ex + e; %we add the noise to the right hand side (rhs)

figure;
subplot(1,3,1)
imagesc(x),colormap gray; title('Exact unknown image')
axis image off
subplot(1,3,2)
imagesc(reshape(b_ex,N,N)),colormap gray; title('Blurred image')
axis image off
subplot(1,3,3)
imagesc(reshape(b,N,N)),colormap gray; title('Blurred noisy image')
axis image off


%Reconstruct the image by multiplying the vector 'b' by the inverse of
%'A'
xnaive=A\b; 
figure
imagesc(reshape(xnaive,N,N)), colormap gray,
axis image off
title( 'Image reconstructed as A^{-1}*b')



%SVD
[U,s,V] =csvd(A); %sparse SVD
% save xnaive.mat
% save U.mat
% save s.mat
% save V.mat

load('xnaive.mat')
load('U.mat')
load('s.mat')
load('V.mat')

figure;
picard(U,s,b);
%KA=s(1)/s(end); % we can compute the condiction number of A
%After plotting the DCP plot, try to look for a reliable threshold

%%%%%%%%%%%
%TSVD
%%%%%%%%%%%

%let's truncate at the r=2340 for example
rPicard=400;
x_r = tsvd(U,s,V,b,rPicard);
figure;
imagesc(reshape(x_r,N,N)), colormap gray;
axis image off
%c = caxis;
title('TSVD r=400')

%%%%%%%%%%%
%Tikhonov
%%%%%%%%%%%

%%%%
[x_lambda,rho,eta] = tikhonov(U,s,V,b,s(rPicard));

figure;
imagesc(reshape(x_lambda,N,N)), colormap gray;
axis image off
title('Tikhonov \lambda from Picard')


%figure;
%subplot(1,2,1)
%imagesc(reshape(x_r,N,N)), colormap gray;
% axis image off
% title('TSVD r from Picard')
% subplot(1,2,2)
% imagesc(reshape(x_lambda,N,N)), colormap gray;
% axis image off
% title('Tikh. \lambda from Picard')

figure;
subplot(2,2,1)
imagesc(reshape(x_r,N,N)), colormap gray;
axis image off
title('TSVD r from Picard')
subplot(2,2,2)
imagesc(reshape(x_lambda,N,N)), colormap gray;
axis image off
title('Tikh. \lambda from Picard')
subplot(2,2,3)
imagesc(reshape(x,N,N)), colormap gray;
axis image off
title('Exact unknown image (x)')
subplot (2,2,4)
imagesc(reshape(b,N,N)), colormap gray;
axis image off
title('Blurred noisy image (b)')


