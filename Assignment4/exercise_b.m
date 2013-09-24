% Load the generated data file
importfile('data\generated_data.mat');

% Read the x and y coordinates from the generated data
data = generated_data(:,1:2);

% Read the classes from the generated data
classes = generated_data(:,3);

% Extract the x point for plotting
x = data(:,1);
% Extract the y point for plotting
y = data(:,2);

gam = 10;
sig2 = 0.4;
type = 'c';

figure(1)
% Without preprocessing
[alpha,b] = trainlssvm({data,classes,'c',gam,sig2, 'RBF_kernel', 'original'});
plotlssvm({data,classes,'c',gam,sig2, 'RBF_kernel', 'original'},{alpha,b});

figure(2)
% With preprocessing
[alpha,b] = trainlssvm({data,classes,'c',gam,sig2, 'RBF_kernel', 'preprocess'});
plotlssvm({data,classes,'c',gam,sig2, 'RBF_kernel', 'preprocess'},{alpha,b});