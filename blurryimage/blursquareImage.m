function [A,b] = blursquareImage(N,x,band,sigma)
%This function provides a basic framework for simulating blurring effects on an image, typically used in image processing for tasks like deblurring (restoring a blurred image)
%BLUR Test problem: digital image deblurring.
%
% function [A,b] = blursquareImage(N,x,band,sigma)
%
% The matrix A is an N*N-by-N*N symmetric, doubly block Toeplitz matrix that
% models blurring of an N-by-N image by a Gaussian point spread function.
% It is stored in sparse matrix format.
%
% x is a N*N matrix (the image that we want to blur)
% band: Half-bandwidth for constructing the matrix A. Determines how many diagonals of the matrix have non-zero elements (how wide the band is).
% In each Toeplitz block, only matrix elements within a distance band-1
% from the diagonal are nonzero (i.e., band is the half-bandwidth).
% If band is not specified, band = 3 is used.
%
% The parameter sigma controls the width of the Gaussian point spread
% function and thus the amount of smoothing (the larger the sigma, the wider
% the function and the more ill posed the problem).  If sigma is not
% specified, sigma = 0.7 is used.
%
% The vector x is a columnwise stacked version of a simple test image, while
% b holds a columnwise stacked version of the blurrred image; i.e, b = A*x.

% Per Christian Hansen, IMM, 11/11/97. 
% Slowly modified and commented in 2023


% Initialization.
if (nargin < 3), band = 3; end %If fewer than 3 arguments are provided, band is set to 3.
band = min(band,N);
if (nargin < 4), sigma = 0.9; end %If fewer than 4 arguments are provided, sigma is set to 0.9.

% Construct the matrix as a Kronecker product.
z = [exp(-((0:band-1).^2)/(2*sigma^2)),zeros(1,N-band)]; %This vector contains values from a Gaussian distribution, which is used to construct the first row of the Toeplitz matrix. The Gaussian kernel is defined as exp(-x^2 / (2 * sigma^2)).
A = toeplitz(z); %Constructs a symmetric Toeplitz matrix A using z. In a Toeplitz matrix, each descending diagonal from left to right is constant.
A = sparse(A); %Converts matrix A into a sparse matrix to save memory and computation time.
A = (1/(2*pi*sigma^2))*kron(A,A); %kron(A,A) Takes the Kronecker product of A with itself. This operation is used to model the 2D blurring operation for the image.
                                  %The matrix is then scaled by (1/(2*pi*sigma^2)), which normalizes the Gaussian blur.
% Make sure x is N-times-N, and stack the columns of x.
x = reshape(x(1:N,1:N),N^2,1); % Reshapes the input image x, which is a N x N matrix, into a column vector of size N^2 x 1. This is necessary because the matrix A is N^2 x N^2, so the image must also be a column vector to perform the matrix multiplication.

% Generate b, if required.
if (nargout > 1) % If more than one output is requested, the function computes the blurred image, b
  % Compute the blurred image.
  b = A*x;
end