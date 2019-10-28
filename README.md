# EDAEPRec
The Code is created based on the method described in the following paper:  
Highly Undersampled Magnetic Resonance Imaging Reconstruction using Autoencoding Priors, Submitted to Magnetic Resonance in Medicine, 2018.  
Author: Q. Liu, Q. Yang, H. Cheng, S. Wang, M. Zhang, D. Liang*.  
Date : 11/2018  
Version : 1.0  
The code and the algorithm are for non-comercial use only.  
Copyright 2018, Department of Electronic Information Engineering, Nanchang University.  
Paul C. Lauterbur Research Center for Biomedical Imaging, Shenzhen Institutes of Advanced Technology, Chinese Academy of Sciences, Shenzhen 518055, China    
Medical AI research center, Shenzhen Institutes of Advanced Technology, Chinese Academy of Sciences, Shenzhen 518055, China    

EDAEPRec - Enhanced Denoising Autoencoder Prior for Reconstruction  

## The Flowchart of EDAEPRec
![](./figs/fig1.png)  
Top：The network learning phase. Bottom: The MRI reconstruction phase.   
## Reconstruction results by various methods at 85% 2D random undersampling.
![](./figs/compare_fig.png)  
From Top to Bottom and from Left to Right：Ground-truth, DLMRI, PANO, NLR-CS; FDLCP, DC-CNN, DAEPRec, EDAEPRec. 

## Test Data
In file './test_data_31', 31 complex-valued MRI data with size of 256x256 were acquired by using a 3D fast-spin-echo (FSE) sequence with T2 weighting from a 3.0T whole body MR system (SIEMENS MAGNETOM TrioTim).

## [<font size=5>**[Paper]**</font>](https://cardiacmr.hms.harvard.edu/files/cardiacmr/files/liu2019.pdf)
Liu Q, Yang Q, Cheng H, et al. Highly undersampled magnetic resonance imaging reconstruction using autoencoding priors[J]. Magnetic resonance in medicine, 2019.
## Other Related Projects
[<font size=5>**[MEDAEP]**</font>](https://cardiacmr.hms.harvard.edu/files/cardiacmr/files/liu2019.pdf): Multi-Channel and Multi-Model-Based Autoencoding Prior for Grayscale Image Restoration  
[<font size=5>**[WDAEPRec]**</font>](https://arxiv.org/ftp/arxiv/papers/1909/1909.01108.pdf): Denoising Auto-encoding Priors in Undecimated Wavelet Domain for MR Image Reconstruction  
[<font size=5>**[HFDAEP]**</font>](https://arxiv.org/ftp/arxiv/papers/1910/1910.11148.pdf): Learning Priors in High-frequency Domain for Inverse Imaging Reconstruction
