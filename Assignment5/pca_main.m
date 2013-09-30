% Using raw pics data 
import_pics('data\pics.mat')

% Apply PCA on the picture data
[pc,score,latent,tsquare] = princomp(pics);

% Find the cumulative sum of how much do the components account for x% of
% the data
cum = cumsum(latent)./sum(latent);

% Plot the relationship between numbers of components used and the amount
% of data they represent
figure; hold on
title('Percentage of data represented by the number of components');
xlabel('Number of principal components');
ylabel('Percentage of data represented');
plot([1:2576], cum)
hold off

% To store average MSE of using different numbers of components to perform
% encoding and decoding
avg_error = [];

% For plot position purposes
counter = 1;

% Plot the original image of one person
figure; hold on
title('Original image vs reconstructions (Read from left to right)');
subplot(5,5,counter);
img_in = pics(1,:);
img_in_disp = sum(abs(img_in).^2, 3).^0.5;
img_in_disp = img_in_disp./max(img_in_disp(:));
img_in_disp = reshape(img_in_disp,56,46);
imshow(img_in_disp);

% To store the indeces of how many components account for x% of data
pc_indices = [];

% Percentage of data represented by x number of components
percentages= [[cum(1):0.05:0.95] [0.95:0.01:0.99]];

% Find the number of components that account for a certain percentage of
% the data
for i=percentages,
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
    
    % Plot the decoded image
    counter = counter + 1;
    subplot(5,5,counter);
    img_in = dec(1,:);
    img_in_disp = sum(abs(img_in).^2, 3).^0.5;
    img_in_disp = img_in_disp./max(img_in_disp(:));
    img_in_disp = reshape(img_in_disp,56,46);
    imshow(img_in_disp);
end

hold off
% Number the number of components that yielded the lowest error
min_ = min(avg_error);
index_min = find(avg_error==min_);
   
% Plot the MSE of using different number of components
figure; hold on
title('MSE vs number of components');
xlabel('Number of components used');
ylabel('MSE');
plot(pc_indices, avg_error)
hold off