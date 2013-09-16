function err = create_mlp_and_test(training_points, training_targets, test_points,test_targets)
    global num_hidden;
    global num_iterations;
    net = mlp(1,num_hidden,1,'softmax');
    mlptrain(net,training_points,training_targets,num_iterations);
    err = mlperr(net,test_points,test_targets);
end