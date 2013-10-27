function [ avg_error ] = mypca( data, desired_num_features )

% Apply PCA on the picture data
[pc,score,latent,tsquare] = princomp(data);

% Encode the data
enc = data(:,:) * pc(:,1:desired_num_features);

end

