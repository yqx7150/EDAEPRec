function Im_Rec = EDAEPRec_15_25(Im_Rec, Partial_data, mask, sigma_d, Noise_repeat_num, display_flag, params, params2)
% Inputs:
% Partial_data: partially observed k-space data.
% mask: sampling mask.
% sigma_d: Noise standard deviation in Partial k-space data.
% Noise_repeat_num: the repeat number of noise generation.
% display_flag: display the result or not.
% params: Set of parameters with regard to network 1.
% params2: Set of parameters with regard to network 2.
%
% Optional parameters:
%   - params.sigma_net: The standard deviation of the network training noise. default: 15, 25
%   - params.num_iter: Specifies number of iterations.default: 200
%   - params.mu: The momentum for SGD optimization. default: 0.9
%   - params.alpha the step length in SGD optimization. default: 0.1
%
% Outputs:
%   - Im_Rec: Solution.

%
% rand('seed',1); %%%%%%%%%
if ~any(strcmp('net',fieldnames(params)))
    error('Need a EDAE network in params.net!');
end

if ~any(strcmp('sigma_net',fieldnames(params)))
    params.sigma_net = 15; params2.sigma_net = 25;
end

if ~any(strcmp('num_iter',fieldnames(params)))
    params.num_iter = 200;
end

if ~any(strcmp('mu',fieldnames(params)))
    params.mu = .9;
end

if ~any(strcmp('alpha',fieldnames(params)))
    params.alpha = .1;
end

if display_flag == 1, disp(params); end

step = zeros(size(Im_Rec));

if display_flag == 1 && any(strcmp('gt',fieldnames(params)))
    psnr = computePSNR(abs(params.gt), abs(Im_Rec), [0 0]);
    disp(['Initialized with PSNR: ' num2str(psnr)]);
end

for iter = 1:params.num_iter
    if display_flag == 1, disp(['Running iteration: ' num2str(iter)]);  tic();    end
    prior_err_sum = zeros(size(Im_Rec));
    map_all = repmat(Im_Rec,[1,1,3]);    
    input_1 = real(map_all);
    input_2 = imag(map_all);
    input = cat(3,input_1,input_2);
    
    for iiii = 1:Noise_repeat_num
        
        noise = randn(size(input)) * params.sigma_net;
        rec = params.net.forward({input+noise});
        
        prior_err = input - rec{1};
        rec = params.net.backward({-prior_err});
        prior_err = prior_err + rec{1};
        
        prior_err1 = mean(prior_err(:,:,1:3),3);
        prior_err2 = mean(prior_err(:,:,4:6),3);
        prior_err_sum = prior_err_sum + prior_err1+sqrt(-1)*prior_err2;
        
    end
    
    for iiii = 1:Noise_repeat_num
        noise = randn(size(input)) * params2.sigma_net;
        rec = params2.net.forward({input+noise});
        
        prior_err = input - rec{1};
        rec = params2.net.backward({-prior_err});
        prior_err = prior_err + rec{1};
        
        prior_err1 = mean(prior_err(:,:,1:3),3);
        prior_err2 = mean(prior_err(:,:,4:6),3);
        prior_err_sum = prior_err_sum + prior_err1+sqrt(-1)*prior_err2;
    end
    
    % sum the gradients and update the regularization term
    prior_err = prior_err_sum/Noise_repeat_num/2;
    step = params.mu * step - params.alpha * prior_err;
    Im_Rec = Im_Rec + step;
    
    % data-fidelity constraint
    if sigma_d == 0
        temp_FFT = fft2(Im_Rec);
        temp_FFT(mask==1) = Partial_data(mask==1);  %
        Im_Rec = ifft2(temp_FFT);
    end
    % Im_Rec = min(255,max(0,Im_Rec));
    
    if display_flag == 1
        if mod(iter,30)==0, figure(200+iter);imshow(abs(Im_Rec),[]);end
        if any(strcmp('gt',fieldnames(params)))
            psnr(iter) = computePSNR(abs(params.gt), abs(Im_Rec), [0 0]);
            disp(['PSNR is: ' num2str(psnr(iter)) ', iteration finished in ' num2str(toc()) ' seconds']);
        end
    end
    
end
