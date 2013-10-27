function [ encoded_data ] = mypca( data, desired_num_features )

% Apply PCA on the picture data
[pc,score,latent,tsquare] = princomp(data);

% Encode the data
encoded_data = data(:,:) * pc(:,1:desired_num_features);

end

