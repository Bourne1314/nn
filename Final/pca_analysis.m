function [ avg_error ] = pca_analysis( data )

num_features = size(data,2);

% Apply PCA on the picture data
[pc,score,latent,tsquare] = princomp(data);

% Find the cumulative sum of how much do the components account for x% of
% the data
cum = cumsum(latent)./sum(latent);

% Plot the relationship between numbers of components used and the amount
% of data they represent
figure; hold on
title('Percentage of data represented by the number of components');
xlabel('Number of principal components');
ylabel('Percentage of data represented');
plot([1:num_features], cum)
hold off

% To store average MSE of using different numbers of components to perform
% encoding and decoding
avg_error = [];

% To store the indeces of how many components account for x% of data
pc_indices = [1:1:num_features];

for ind=pc_indices
    % Encode the data
    enc = data(:,:) * pc(:,1:ind);
    % Decode the data
    dec = enc * pc(:,1:ind)';    
    % Calculate the MSE between the original and the decoded
    avg_error = [avg_error mse_error(data,dec)];
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

end

