% Using raw pics data 
import_pics('data\pics.mat')

% Apply PCA on the picture data
[pc,score,latent,tsquare] = princomp(pics);

% Find the cumulative sum of how much do the components account for x% of
% the data
cum = cumsum(latent)./sum(latent);

% To store average MSE of using different numbers of components to perform
% encoding and decoding
avg_error = [];

% Plot the original image of one person
figure
subplot(1,2,1);
img_in = pics(1,:);
img_in_disp = sum(abs(img_in).^2, 3).^0.5;
img_in_disp = img_in_disp./max(img_in_disp(:));
img_in_disp = reshape(img_in_disp,56,46);
imshow(img_in_disp);

% To store the indeces of how many components account for x% of data
pc_indices = [];
for i=cum(1):0.05:1,
    ind = max(find(cum<=i));
    pc_indices = [pc_indices ind];
end

for ind=pc_indices
    % Encode the data
    enc = pics(:,:) * pc(:,1:ind);
    % Decode the data
    dec = enc * pc(:,1:ind)';    
    % Calculate the MSE between the original and the decoded
    avg_error = [avg_error mse_error(pics,dec)];
end

% Number the number of components that yielded the lowest error
min_ = min(avg_error);
index_min = find(avg_error==min_);

% Use the numbers of components that yielded the lowest error to enconde
% and decode
ind = pc_indices(index_min);
enc = pics(:,:) * pc(:,1:ind);
dec = enc * pc(:,1:ind)';

% Plot decoded picture
subplot(1,2,2);
img_in = dec(1,:);
img_in_disp = sum(abs(img_in).^2, 3).^0.5;
img_in_disp = img_in_disp./max(img_in_disp(:));
img_in_disp = reshape(img_in_disp,56,46);
imshow(img_in_disp);
    
% Plot the MSE of using different number of components
figure
plot(pc_indices, avg_error)
