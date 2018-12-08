%% The Code is created based on the method described in the following paper:
% Highly Undersampled Magnetic Resonance Imaging Reconstruction using Autoencoding Priors, Submitted to Magnetic Resonance in Medicine, 2018.
% Author: Q. Liu, Q. Yang, H. Cheng, S. Wang, M. Zhang, D. Liang.
% Date : 11/2018
% Version : 1.0
% The code and the algorithm are for non-comercial use only.
% Copyright 2018, Department of Electronic Information Engineering, Nanchang University.
% Paul C. Lauterbur Research Center for Biomedical Imaging, Shenzhen Institutes of Advanced Technology, Chinese Academy of Sciences, Shenzhen 518055, China
% Medical AI research center, Shenzhen Institutes of Advanced Technology, Chinese Academy of Sciences, Shenzhen 518055, China

% EDAEPRec - Enhanced Denoising Autoencoder Prior for Reconstruction 

clear; 
clc; 
% addpath ../siavash/caffe/matlab; % add MatCaffe path
getd = @(p)path(path,p);% Add some directories to the path
getd('./mask/');
getd('./model/');
getd('./quality_assess/');
getd('./testdata/');
getd('./utilities/');

%#######%%%%% set to 0 if you want to run on CPU (very slow) %%%%
use_gpu = 1;

%% Reconstruction demo
%#######%%%%% read sampling %%%%
load mask_radial_85; mask = mask_radial_015; 
mask = fftshift(fftshift(mask,1),2);
figure(356); imshow(fftshift(mask),[]);   %
n = size(mask,2);
fprintf(1, 'n=%d, k=%d, Unsamped=%f\n', n, sum(sum(mask)),1-sum(sum(mask))/n/n); %

%#######%%%%% read test image %%%%
load Test2;  Img = imrotate(Img, 90); Img(:,end-6:end) = []; Img(:,1:7) = [];
gt = 255*Img./max(abs(Img(:)));
figure(334);imshow(abs(gt),[]);

%#######%%%%% generate partial samples %%%%
sigma_d = 0 * 255;
noise = randn(size(gt));
Partial_data = mask.*(fft2(gt) + noise * sigma_d + (0+1i)*noise * sigma_d); %
Im = ifft2(Partial_data); 
figure(335);imshow(abs(Im),[]);

%#######%%%%% load network for solver %%%%
params.net = loadNet_qx3channel_diffSigma([size(gt),3], use_gpu);
params.gt = gt;

params2.net = loadNet_qx3channel_diffSigma2([size(gt),3], use_gpu);
params2.gt = gt;

%#######%%%%% run EDAEPRec %%%%
params.sigma_net = 15;   
params.num_iter = 200;
params2.sigma_net = 25;  
params2.num_iter = params.num_iter;
Noise_repeat_num = 3;  %3;   %8;  %1; %12;
display_flag = 1;
min_max_flag = 1; %if the max and min values of the groundtruth is known to be 255 and 0;  
Im_Rec = EDAEPRec_15_25(Im, Partial_data, mask, sigma_d, Noise_repeat_num, display_flag, params, params2);

%#######%%%%% result evaluation %%%%
[psnr, ssim, ~] = MSIQA(abs(gt), abs(Im_Rec));
hfen = norm(imfilter(abs(Im_Rec/255),fspecial('log',15,1.5)) - imfilter(abs(gt/255),fspecial('log',15,1.5)),'fro');
disp(['PSNR =  ' num2str(psnr) ]);
disp(['SSIM =  ' num2str(ssim) ]);
disp(['HFEN =  ' num2str(hfen) ]);

%#######%%%%% result display %%%%
figure(666);subplot(1,3,1);imshow(abs(gt)/255); title('Ground-truth');colormap(gray);
subplot(1,3,2);imshow(abs(Im)/255); title('Zero-filled');colormap(gray);
subplot(1,3,3);imshow(abs(Im_Rec)/255); title('Net-recon');colormap(gray);

figure(667);imshow([real(gt)/255,imag(gt)/255,abs(gt)/255],[]); 
figure(668);imshow([abs(Im-gt)/255,abs(Im_Rec-gt)/255],[]); colormap(jet);colorbar;


