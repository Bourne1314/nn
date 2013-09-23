function result = assignment3a()
    global num_hidden;
    global num_iterations;
    result = zeros(3,1,5);
    dataset_i = 0;
    datasets_names = {'line.mat','sinus.mat','irregular.mat'};
    hs = [2,3,4,5,7,10,15,25,213];
    for dataset = datasets_names,
        dataset_i = dataset_i + 1;
        load(dataset{1});
        
        for hi = 1:size(hs,2),
            num_hidden = hs(hi);
            for j = 1:size(result,3),
                num_iterations = 100;
                cv_err = crossvalidation(5,@create_mlp_and_test,x,t);
                result(dataset_i, hi, j) = cv_err;
                [dataset_i, hi, j, num_hidden, num_iterations, cv_err]
            end
        end
    end
    mean_line = mean(mean(result(1,:,:)))
    mean_sinus = mean(mean(result(2,:,:)))
    mean_irregular = mean(mean(result(3,:,:)))
    means_hidden = mean(result,3);
    means_total = mean(means_hidden,2);
    for i = 1:3,
        plot(1:9, means_hidden(i,:), '-o');
        set(gca,'XTickLabel', hs );
        title(datasets_names(i));
        xlabel('hidden nodes');
        ylabel('error');
    end
end