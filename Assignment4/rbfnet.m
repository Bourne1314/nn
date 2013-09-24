function [errors avg_error] = rbfnet(input_data, class, classGlass)

    hidden_nodes = [2,3,4,5,7,10,15,25];   
    
    classGlass = classGlass';

    % The number of folds to use
    number_of_folds = 10;

    % Reset the random seed
    rng(10);
    % Separate the data into 10 different data sets. Indices(x) indicates that
    % element x belongs to a particular cross validation
    indices = crossvalind('Kfold', class, number_of_folds);

    % Different selection strategy. 1st example of every person 
    % to be in fold #1, the 2nd example of every person to be in fold #2 
    % and so on
    %indices = repmat([1:10],1,40);

    % To store the errors
    errors = [];
    nets = [];

    for hidden_node = hidden_nodes,

        % Store the nets for every cross validation set for this number of
        % hidden nodes
        tmp_nets = [];

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

            % Create neural net
            net = rbf(2576, hidden_node, 1, 'gaussian');
    
            options = foptions();
            options(1) = 0;
            options(5) = 0;
            options(6) = 1;
            options(14) = 25;            
            
            % Train the network
            net = rbftrain(net, options, training_data, training_classes);

            % Apply the model to data
            y = rbffwd(net, test_data);            

            % Calculate mean square error
            error = mse_error(test_classes, y);
            tmp_nets = [tmp_nets net];        
            tmp_errors = [tmp_errors error];
        end

        % Store all the nets resulting from every complete run using a
        % particular number of hidden nodes
        nets = [nets; tmp_nets];

        % Store all the errors resulting from every complete run using a
        % particular number of hidden nodes
        errors = [errors; tmp_errors];

    end

    avg_error = mean(errors,2);

    % Plot avg error vs hidden nodes
    figure; hold on
    axis([0 25 0 1])
    set(gca,'XTick', 0:1:25);
    set(gca,'YTick', 0:0.1:1);
    title('Average error of network per number of hidden nodes');
    xlabel('Number of hidden nodes');
    ylabel('Average network error');
    plot(hidden_nodes, avg_error, '-o');
    hold off
end