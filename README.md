# Inverse Problems and Image Deblurring

This repository contains projects related to solving inverse problems, specifically focusing on image deblurring and computed tomography (CT). The projects utilize techniques like Truncated Singular Value Decomposition (TSVD) and Tikhonov Regularization to address the ill-posed nature of these problems.

## Project Overview

### Image Deblurring

The `blurryimage` folder contains a project that deals with the discrete version of an integral equation representing image blurring. The goal is to recover the original image from a blurred version, considering different levels of additive Gaussian noise.

- **Integral Equation**: The continuous problem is approximated by a discrete linear system $\(Ax = b + \epsilon\)$, where $\(A\)$ is the blurring operator, $\(x\)$ is the original image, $\(b\)$ is the blurred image, and $\(\epsilon\)$ is additive noise.
- **Noise Levels**:
  1. Noise-free
  2. 1% additive noise
  3. 5% additive noise
  4. 10% additive noise

For each noise level, the project uses TSVD and zero-order Tikhonov regularization to compute a regularized approximation $\(x_r\)$ of the original image $\(x\)$ and plots the resulting images. The relative errors $\(\frac{\|x - x_r\|_2}{\|x\|_2}\)$ for both methods are computed and analyzed.

### Computed Tomography (CT) and Regularization Techniques

The `CT` folder addresses ill-posed problems in computed tomography, where the objective is to reconstruct images from projections.

#### Contents

1. **Inverse Problems**:
   - Definition and examples in medical imaging, geophysics, and astronomy.
   - Explanation of ill-posedness and the need for regularization.

2. **Regularization Techniques**:
   - **Tikhonov Regularization**: Adds a penalty term to stabilize the solution.
   - **Truncated Singular Value Decomposition (SVD)**: Truncates smaller singular values to reduce noise impact.
   - **Iterative Methods**: Techniques like the Kaczmarz algorithm for iterative improvement.

3. **Computed Tomography (CT)**:
   - Mathematical formulation of CT image reconstruction.
   - Handling noise and errors in recorded data.
   - Use of regularization to obtain stable and accurate reconstructions.

4. **Case Analysis**:
   - Noise-free case.
   - 1% noise case.
   - 5% noise case.

For each case, the project uses TSVD and zero-order Tikhonov regularization to calculate an approximation $\(x_r\)$ of $\(x\)$ and plots the resulting images. Relative errors for both methods are computed and compared.

#### Results

- **Noise Levels and Relative Errors**:
  | Noise Level | Truncated SVD Relative Error | Tikhonov Regularization Relative Error |
  |-------------|------------------------------|---------------------------------------|
  | Noise-Free  | 0.0014                       | 0.0014                                |
  | 1% Noise    | 0.0017                       | 0.0017                                |
  | 5% Noise    | 0.0023                       | 0.0023                                |

### Author
- **Vishal Nair** - [v1292002@gmail.com](mailto:v1292002@gmail.com)

### Acknowledgement
- **Dr. Judit Chamorro Servent** Universitat Autonoma de Barcelona

## Contact

For any questions or inquiries, please contact:
- Vishal Nair
- Email: [v1292002@gmail.com](mailto:v1292002@gmail.com)
