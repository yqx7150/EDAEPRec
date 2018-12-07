%% function Im_Rec = EDAEPRec_15_25(Im, Partial_data, mask, sigma_d, Noise_repeat_num, display_flag, params, params2)
% Inputs:
% Im: partially observed MR image.
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
