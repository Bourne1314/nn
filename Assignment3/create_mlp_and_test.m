function err = create_mlp_and_test(training_points, training_targets, test_points,test_targets)
    net = mlp(1,5,1,'linear');
    mlptrain(net,training_points,training_targets,10);
    err = mlperr(net,test_points,test_targets);
end