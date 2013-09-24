
class = ones(9);
class = class(1,:);
pics = magic(9);
pics = pics(1:9,1:7)
classGlass = [1:1:9];

number_of_folds = 3;

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

% Store the nets for every cross validation set for this number of
% hidden nodes
tmp_nets = [];

% Store the error for every cross validation set for this number of
% hidden nodes
tmp_errors = [];

% Go through every training set
for i = 1:number_of_folds,            

    % Get the test data
    test_indices = find(indices==i)
    test_data = pics(test_indices,:);
    test_classes = classGlass(test_indices);   

    % Remove the test data from the training set data
    data_indices = find(indices~=i);              
    
    % With the indices get all the inputs for this particular set
    training_data = pics(data_indices,:);
    % With the indices get all the classes for this particular set
    training_classes = classGlass(data_indices);
    
    training_data
    test_data
end

