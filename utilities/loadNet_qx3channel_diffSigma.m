function net = loadNet_qx3channel_diffSigma(img_size, use_gpu)
% Loads a Caffe 'net' object for a specific image dimensions
%
%
% Input:
% img_size: MAP Image size [Height, Width].
% use_gpu: GPU flag: use 1 if you use GPU, use 0 to run on CPU.
%
% Output:
% map: Caffe 'net' object.

%%
net_size = [img_size(3), img_size(2), img_size(1)];

caffe.reset_all();

if use_gpu
    caffe.set_mode_gpu();
    caffe.set_device(0);
else
    caffe.set_mode_cpu();
end

net_model = './model/REDNet_deploy_base.prototxt';

net_weights = ['./model/N15_3D.caffemodel'];

FID_base = fopen(net_model, 'r');
Str_base = fread(FID_base, [1, inf]);
fclose(FID_base);
FID_net = fopen('./model/REDNet_deploy_resize.prototxt', 'w');
fprintf(FID_net, char(Str_base), net_size);
fclose(FID_net);
net_model = './model/REDNet_deploy_resize.prototxt';

net = caffe.Net(net_model, net_weights, 'test');
