function [err] = crossvalidation(k,fun,orig_points,orig_targets)
    shuffler = randperm(size(orig_points,1));
    shuffled_points = orig_points(shuffler,:);
    shuffled_targets = orig_targets(shuffler,:);
    dispatcher = crossvalind('Kfold',size(shuffled_points,1),5);
    ret = dispatcher;
    all_i = 1:k;
    errs = [];
    for test_i = all_i,
        %others_i = all_i(boolean(1 - (all_i == test_i)));
        test_01 = dispatcher == test_i;
        training_01 = boolean(1 - (dispatcher == test_i));
        test_points = shuffled_points(test_01);
        training_points = shuffled_points(training_01);
        test_targets = shuffled_targets(test_01);
        training_targets = shuffled_targets(training_01);
        
        % training and testing is done in 'fun'
        errs = [errs fun(training_points,training_targets,test_points,test_targets)];
    end
    err = mean(errs);
end
