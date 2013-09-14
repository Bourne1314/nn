% Load the given data
importfile('two_class_example_not_separable.dat');

% Extract the x point for plotting
x = two_class_example_not_separable(:,1);
% Extract the y point for plotting
y = two_class_example_not_separable(:,2);
% Extract the classes for plotting
classes = two_class_example_not_separable(:,3);

% Plot all the data points
plot_data(x,y,classes);

% Change every class "0" to a "-1" class so that the data is in line with what it expected by the algorithm
classes(classes == 0) = -1;

% Reconstruct the data points for the non_separable data
non_sep_data = [x y];

[weights iterations predicted_classes] = perceptron(non_sep_data, classes, 0.1, 100, 1);
% Call the perceptron

% Plot the data and the decision line
plot_data_and_decision_boundary(non_sep_data, classes, weights);

% Run the perceptron for a given set of learning rates with a max number of 100 iterations. This will also generate a plot of the learning_rates vs the MSEs
assignment1c(non_sep_data, classes, 100);