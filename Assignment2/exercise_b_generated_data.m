% Load the generated data file
importfile('generated_data.mat');

% Read the x and y coordinates from the generated data
data = generated_data(:,1:2);

% Read the classes from the generated data
classes = generated_data(:,3);

% create a generalised linear model
net = glm(2, 1, 'linear');

% apply the model to data x
y = glmfwd(net, data);

% calculate the error
options = foptions;
options(1) = 0;
% Number of iterations
options(14) = 100;;

% train the network using the iterative reweighted least squares (IRLS) algorithm
net = glmtrain(net, options, data, classes);

% plot the data and the decision boundary
plot_data_and_decision_boundary(data, classes, [net.b1 net.w1'])

error = glmerr(net, data, classes);
error
