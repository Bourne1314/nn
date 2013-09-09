% Function   :  assignment1c 
% 
% Purpose    :  This function make a call to the perceptron neural network to
% perform binary classification, using several different learning rates and
% then plots the resulting error of using each learning rate vs the
% learning rate used.
% 
% Parameters :  + data - the data points
%               + class - the assigned class to every data point
%
% Return     :  + mses - the resulting mean squared errors for every run of
% the perceptron using every learning rate
% 
function [ mses ] = assignment1c (data, classes, max_iterations)
    % The learning rates to be used.
    learning_rates = [0.01:0.01:1];
    
    % Initialize variable to store the mses for every learning rate
    mses = [];
    
    % Run once through every learning rate
    for lr=learning_rates,
        % Call the perceptron function with a max number of iterations
        [weights stopping_iteration predicted_classes] = perceptron(data, classes, lr, max_iterations, 0);
        
        % The mse for the call above
        curr_mse = calculate_error(classes, predicted_classes);
        
        % Add the current mse to final result
        mses = [ mses curr_mse];
    end
    
    % Once we have all the mses plot them vs the learning rates
    plot_iteration_vs_learning_rate(learning_rates, mses);  
    
end

% Function   :  calculate_error 
% 
% Purpose    :  This function calculates the MSE between a set 
%               of given classes and a set of predicted classes 
% 
% Parameters :  + real_class - the real, known classes for every data point
%               + predicted_class - the predicted classes for every data point
%
% Return     :  The MSE between the real classes and the predicted
%               classes
function [error] = calculate_error(real_class, predicted_class)
   D = abs(real_class-predicted_class).^2;
   error = sum(D(:))/numel(real_class);
end

% Function   :  plot_iteration_vs_learning_rate 
% 
% Purpose    :  This function plots the given learning rates vs given the mses 
% 
% Parameters :  + plot_iteration_vs_learning_rate - the different learning
%                rates
%               + mses - the mse corresponding to every learning rate
%
% Return     :  No return values 
function [] = plot_iteration_vs_learning_rate(learning_rates, mses)
    figure,hold on
    xlabel('Learning rate')
    ylabel('MSE')
    title('\it{Mean squared error over learning rate}')
    plot(learning_rates, mses);
    hold off
end