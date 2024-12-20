% [x, errors, xNorms] = ARTReconstruction_Fast(A, b, relaxationParameter, nbIterations, x0)
%
% Algebraic reconstruction technique, also known as Kaczmarz method.
%
% Inputs:
% 
% A                      = System matrix or Jacobian matrix, nr x nc
%                        = d, data, nr x 1
% nbIterations           = number of iterations
% relaxationParameter    = relaxation parameter (between 0 and 1). Choose 0.1 to
% remove noise and 0.9 to get a closer fit of the data
% x0                     = initial guess of the solution image, nc x 1. Initialize
% as zeros(nc,1) 
%
% Outputs:
%
% x      = solution image, nc x 1
% errors = Optional output vector indicating the solution error per iteration.
% xNorms = Optional output vector indicating the norm of the solution at each iteration
%
% Modified 2017-04-22 by Tom Vettenburg  (3-4 fold)

function [x, errors, xNorms] = ARTReconstruction_Fast(A, b, relaxationParameter, nbIterations, x0)
    if nargin<1 || isempty(A)
        nbEqn = 1000;
        nbVar = nbEqn;
        A = randn(nbEqn, nbVar);
        clear nbEqn nbVar
    end
    [nbEquations, nbVariables] = size(A);
    if nargin<2 || isempty(b)
        b = A*ones(nbVariables, 1);
    end
     if nargin<3 || isempty(relaxationParameter)
        relaxationParameter = 1;
    end
    if nargin<4 || isempty(nbIterations)
        nbIterations = 100;
    end
    if nargin<5 || isempty(x0)
        x0 = zeros(nbVariables, 1, 'double');
    end
   
    
    wantPerformanceFigures = nargout~=1;
    
    % Initialization.
    if wantPerformanceFigures
        errors = zeros(1, nbIterations);
        xNorms = zeros(1, nbIterations);
    end
    
    % precalculate the equation sqd weights
    weights = relaxationParameter./sum(abs(A).^2, 2); % column vectors are more efficient
        
    % replace with transpose for efficiency
    A = A.';
    
    % do the Kaczmarz iteration
    x = x0;
    for itIdx = 1:nbIterations
        for eqnIdx = 1:nbEquations % should actually be chosen randomly with a distribution proportional to equationSqdNorms
            V = A(:, eqnIdx);
            x = x + (b(eqnIdx)-V'*x)*weights(eqnIdx)*V;
        end
        if wantPerformanceFigures
            errors(itIdx) = norm(b-A.'*x);
            xNorms(itIdx) = norm(x);
        end
    end
    
    clear A;
    
    if nargout == 0 && wantPerformanceFigures
        close all;
        %fig = figure();
        figure();
        axs(1) = subplot(1,2,1);
        semilogy(1:nbIterations, errors); title('error');
        xlabel('iteration'); ylabel('error');
        axs(2) = subplot(1,2,2);
        semilogy(1:nbIterations, xNorms); title('xNorm');
        xlabel('iteration'); ylabel('xNorm');
        
        linkaxes(axs, 'x');
        
        clear x;
    end
end