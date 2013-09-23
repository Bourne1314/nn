function err = create_mlp_and_test(training_points, training_targets, test_points,test_targets)
    global num_hidden;
    global num_iterations;
    net_untrained = mlp(1,num_hidden,1,'linear');
    [net_trained train_error ] = mlptrain(net_untrained,training_points,training_targets,num_iterations);
    y = mlpfwd(net_trained, test_points); 
    % [ y test_targets ] % decomment if you want to see differences
    err = mse(y, test_targets);
    % [err]
end
