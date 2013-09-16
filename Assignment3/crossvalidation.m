function [err] = crossvalidation(k,fun,points,targets)
    dispatcher = crossvalind('Kfold',size(points,1),5);
    ret = dispatcher;
    all_i = 1:k;
    errs = [];
    for test_i = all_i,
        %others_i = all_i(boolean(1 - (all_i == test_i)));
        test_01 = dispatcher == test_i;
        training_01 = boolean(1 - (dispatcher == test_i));
        test_points = points(test_01);
        training_points = points(training_01);
        test_targets = targets(test_01);
        training_targets = targets(training_01);
        
        % training and testing is done in 'fun'
        errs = [errs fun(training_points,training_targets,test_points,test_targets)];
    end
    err = mean(errs);
end
