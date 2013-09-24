function [errors avg_error] = svmfunc(input_data, class, classGlass)
    
    classGlass = classGlass';

    % The number of folds to use
    number_of_folds = 10;

    % Reset the random seed
    rand('state',10)
    % Separate the data into 10 different data sets. Indices(x) indicates that
    % element x belongs to a particular cross validation
    indices = crossvalind('Kfold', class, number_of_folds);

    % Different selection strategy. 1st example of every person 
    % to be in fold #1, the 2nd example of every person to be in fold #2 
    % and so on
    %indices = repmat([1:10],1,40);
    
    % To store the errors
    errors = [];
        
    % Parameters for SVM
    type = 'c';

    

    % Store the error for every cross validation set for this number of
    % hidden nodes
    tmp_errors = [];

    % Go through every training set
    for i = 1:number_of_folds,            

        % Get the test data
        test_indices = find(indices==i);
        test_data = input_data(test_indices,:);
        test_classes = classGlass(test_indices);   

        % Remove the test data from the training set data
        data_indices = find(indices~=i);

        % With the indices get all the inputs for this particular set
        training_data = input_data(data_indices,:);
        % With the indices get all the classes for this particular set
        training_classes = classGlass(data_indices);

        % Find the best hyperparameters
        [gam,sig2] = tunelssvm({training_data,training_classes,type,[],[]},'simplex', 'crossvalidatelssvm',{number_of_folds,'misclass'});
        
        % Train SVM        
        [alpha,b] = trainlssvm({training_data,training_classes,type,gam,sig2});     

        % Predict class for test data
        y = simlssvm({training_data,training_classes,type,gam,sig2,'RBF_kernel'},{alpha,b},test_data);       

        % Calculate mean square error
        error = mse_error(test_classes, y);

        tmp_errors = [tmp_errors error];
    end

    % Store all the errors resulting from every complete run using a
    % particular number of hidden nodes
    errors = [errors; tmp_errors];

    avg_error = mean(errors,2);

    % Plot avg error vs hidden nodes
    figure; hold on
    axis([0 number_of_folds 0 1])
    set(gca,'XTick', 0:1:number_of_folds);
    set(gca,'YTick', 0:0.1:1);
    title('Prediction error per crossvalidation');
    xlabel('Crossvalidation number');
    ylabel('Average network error');
    plot([1:number_of_folds], errors, '-o');
    hold off
end