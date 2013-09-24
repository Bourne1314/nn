function err = polyfit_tester(training_points, training_targets, test_points,test_targets)
    global degree;
    p = polyfit(training_points, training_targets, degree);
    y = polyval(p,test_points);
    err = mse(y, test_targets);
end