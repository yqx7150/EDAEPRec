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

## The flowchart of EDAEPRec
![](./figs/fig1.png)  
Top：The network learning phase. Bottom: The MRI reconstruction phase.   
## Reconstruction results by various methods at 85% 2D random undersampling.
![](./figs/compare_fig.png)  
From Top to Bottom and from Left to Right：Ground-truth, DLMRI, PANO, NLR-CS; FDLCP, DC-CNN, DAEPRec, EDAEPRec. 

## Test data
In file './test_data_31', 31 complex-valued MRI data with size of 256x256 were acquired by using a 3D fast-spin-echo (FSE) sequence with T2 weighting from a 3.0T whole body MR system (SIEMENS MAGNETOM TrioTim).

[<font size=5>**paper**</font>](https://cardiacmr.hms.harvard.edu/files/cardiacmr/files/liu2019.pdf)

## Other Related Projects
