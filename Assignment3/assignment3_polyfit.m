function result = assignment3_polyfit()
    global degree;
    result = zeros(3,1,5);
    dataset_i = 0;
    datasets_names = {'line.mat','sinus.mat','irregular.mat'};
    degrees = 1:20;
    for dataset = datasets_names,
        dataset_i = dataset_i + 1;
        load(dataset{1});
        
        for degree_i = 1:size(degrees,2),
            degree = degrees(degree_i);
            for j = 1:size(result,3),
                cv_err = crossvalidation(5,@polyfit_tester,x,t);
                result(dataset_i, degree_i, j) = cv_err;
                [dataset_i, degree_i, j, degree, cv_err]
            end
        end
    end
    
    means_degrees = mean(result,3);
    for i = 1:3,
        set(gca,'XTickLabel', degrees );
        semilogy(degrees, means_degrees(i,:), '-o');
        title(datasets_names(i));
        xlabel('degrees');
        ylabel('error');
    end
end