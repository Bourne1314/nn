function [ err ] = ga_func( params )
    
    k = params(1);
    k = floor(k);
    
    pca_n = params(2);
    pca_n = floor(pca_n);

    w = params(3);
    w = floor(w);
    
    hidden_n = params(4);
    if hidden_n < 1,
        err = 1000 - hidden_n
        return
    end
    hidden_n = floor(hidden_n);
    
    zscore_switch = params(5);
    
    global features;
    global data;
    
    % w-dependent features
    features('avg_speed_w') = create_avg_speed_w(data,features('speed'),w);
    features('var_angle_w') = create_var_angle_w(data,features('angle_of_movement'),w);
    
    % k-dependent features
    if k > 1,
        features('centroids') = create_centroids(data,k)
        [ angles_toward_centroids distance_toward_centroids ] = create_angles_and_distances_toward_centroids(data, features('centroids'));
        features('angles_toward_centroids') = angles_toward_centroids;
        features('distance_toward_centroids') = distance_toward_centroids;
    else
        features('centroids') = []
    end
    
    [ input_data target_value ] = create_network_input_and_target_data(...
        data,...
        features, ...
        k ...
    );
    
    if zscore_switch >= -100000000.0,
        norm_input_data = zscore(input_data);
    else
        norm_input_data = input_data;
    end
    
    encoded_data = mypca(norm_input_data, pca_n);
    
    [nets errors avg_error] = train_net(encoded_data, target_value, hidden_n, 100);
end

