function [ err ] = ga_func( k, pca_n, w, hidden_n, zscore_switch)

    global features;
    global data;
    
    % w-dependent features
    features('avg_speed_w') = create_avg_speed_w(data,speed,w);
    features('var_angle_w') = create_var_angle_w(data,angle_of_movement,w);
    
    % k-dependent features
    features('centroids') = create_centroids(data,k)
    [ angles_toward_centroids distance_toward_centroids ] = create_angles_and_distances_toward_centroids(data, centroids);
    features('angles_toward_centroids') = angles_toward_centroids;
    features('distance_toward_centroids') = distance_toward_centroids;
    
    [ input_data target_value ] = create_network_input_and_target_data(...
        data,...
        features ...
    );

    if zscore_switch >= 1.0,
        norm_input_data = zscore(input_data);
    else
        norm_input_data = input_data;
    end
    
    pca_n = floor(pca_n);
    encoded_data = mypca(norm_input_data, pca_n);
    
    [nets errors avg_error] = train_net(encoded_data, target_value, hidden_n, 100);
end

