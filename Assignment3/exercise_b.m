import_pics('data\pics.mat')

hidden_nodes = [2,3,4,5,7,10,15,25];

classGlass = classGlass';

% Reset the random seed
rng(10);
% Separate the data into 10 different data sets. Indices(x) indicates that
% element x belongs to a particular cross validation
indices = crossvalind('Kfold',class,10);

% Split the indices for training ans test. 
data_training_indices = [];
data_test_indices = find(indices==10);

for i=1:9,
    tmp = find(indices==i);
    data_training_indices = [data_training_indices tmp];
end

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
    for i = data_training_indices',
        
        % With the indices get all the inputs for this particular set
        data = pics(i,:);
        % With the indices get all the classes for this particular set
        classes = classGlass(i);
        
        % Create neural net
        net = mlp(2576, hidden_node, 1, 'linear');

        % Train the network using the iterative reweighted least squares (IRLS) algorithm
        net = mlptrain(net, data, classes, 100);
        
        % Apply the model to data
        y = mlpfwd(net, pics(data_test_indices,:));        
        
        % Calculate mean square error
        error = mse_error(classGlass(data_test_indices), y);
        
        % Calculate error of this network
        %error = mlperr(net, pics(data_test_indices,:), classGlass(data_test_indices));
        
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
set(gca,'XTick', 0:1:25);
title('Average error of network per number of hidden nodes');
xlabel('Number of hidden nodes');
ylabel('Average network error');
plot(hidden_nodes, avg_error, '-o');
hold off
