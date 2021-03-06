function [nets errors avg_error] = train_net(input_values, target_values, hidden_nodes, max_iterations_per_net)      
    
	% Number of feature columns
	num_features = size(input_values,2);
	
    % The number of folds to use
    number_of_folds = 10;

    % Reset the random seed
    rng(58);
    % Separate the data into 10 different data sets. Indices(x) indicates that
    % element x belongs to a particular cross validation
    indices = crossvalind('Kfold', target_values(:,1), number_of_folds);

    % Store the different used networks
    nets = [];
    
    % To store the errors
    errors = [];
    
     % Parameters for SVM. 'f' for function estimation
    type = 'c';

    % Go through every training set
    for i = 1:number_of_folds,            

        % Get the test data
        test_indices = find(indices==i);
        test_data = input_values(test_indices,:);
        test_values = target_values(test_indices,:);   

        % Remove the test data from the training set data
        data_indices = find(indices~=i);

        % With the indices get all the inputs for this particular set
        training_data = input_values(data_indices,:);
        % With the indices get all the classes for this particular set
        training_values = target_values(data_indices,:);
  
       % Find the best hyperparameters
        %[gam,sig2] = tunelssvm({training_data,training_values,type,[],[]},'simplex', 'crossvalidatelssvm',{number_of_folds,'mse'});
        
        % Predict class for test data
        y = lssvm(training_data,training_values,type);
              

        % Calculate mean square error
        error = mse_error(test_values, y);       
        errors = [errors error];
        nets = [nets net];
    end  

    avg_error = mean(errors,2);

    % Plot avg error vs hidden nodes
    figure; hold on
    title('Error of network per fold');
    xlabel('Fold number');
    ylabel('Average network error');
    plot([1:number_of_folds], errors);
    hold off
end