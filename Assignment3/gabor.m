function [img_out] = gabor(img_in, show_images)
lambda  = 8;
theta   = 0;
psi     = [0 pi/2];
gamma   = 0.5;
bw      = 1;
N       = 8;
%img_in = reshape(img_in,56,46);

img_out = zeros(size(img_in,1), size(img_in,2), N);

for n=1:N
    gb = gabor_fn(bw,gamma,psi(1),lambda,theta)...
        + 1i * gabor_fn(bw,gamma,psi(2),lambda,theta);
    % gb is the n-th gabor filter
    img_out(:,:,n) = imfilter(img_in, gb, 'symmetric');
    % filter output to the n-th channel
    theta = theta + 2*pi/N;
    % next orientation
end

img_in_disp = sum(abs(img_in).^2, 3).^0.5;
img_in_disp = img_in_disp./max(img_in_disp(:));
   
img_out_disp = sum(abs(img_out).^2, 3).^0.5;
img_out_disp = img_out_disp./max(img_out_disp(:));

img_out = img_out_disp;

if (show_images == 1),
    figure(1);
    
    img_in_disp = reshape(img_in_disp,56,46);
    
    imshow(img_in_disp);
    title('input image');
    figure(2);
    
    % default superposition method, L2-norm
    
    % normalize
    img_out_disp = reshape(img_out_disp,56,46);
    imshow(img_out_disp);
    
    title('gabor output, L-2 super-imposed, normalized');
    
end