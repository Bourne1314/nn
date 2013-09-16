% Load the generated data file
importfile('two_class_example_not_separable.dat');

% Read the x and y coordinates from the data
data = two_class_example_not_separable(:,1:2);

% Read the classes from the data
classes = two_class_example_not_separable(:,3);

% Rename class 0 to class -1
classes(classes == 0) = -1;

% create a generalised linear model with 2 inputs and 1 output
net = glm(2, 1, 'softmax');

% apply the model to data x
y = glmfwd(net, data);

options = foptions;
options(1) = 0;
% Number of iterations
options(14) = 100;

% train the network using the iterative reweighted least squares (IRLS) algorithm
net = glmtrain(net, options, data, classes);

% plot the data and the decision boundary
plot_data_and_decision_boundary(data, classes, [net.b1 net.w1'])

% calculate the error
error = glmerr(net, data, classes);
error
