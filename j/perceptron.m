% Function   :  Perceptron 
% 
% Purpose    :  This function implements a perceptron neural network to
% perform binary classification.
% 
% Parameters :  + data - the data points
%               + class - the assigned class to every data point
%               + learning_rate - the perceptron learning rate
%               + iterations - the maximum numbers of iterations to perform
%               + plot_error (optional) - If set to 1, the function will
%               plot a graph of the prediction error over the iterations.
%               Default is 0.
%
% Return     :  + weigths - the calculated weights by the perceptron
%               + stopping_iteration - the iteration at which the code
%               finished. It either iterates until it reached the maximum
%               or until a convergence point is reached
%               + predicted_classes - the predicted class for every input
% 

function [weights, stopping_iteration, predicted_classes] = perceptron(data, class, learning_rate, iterations, plot_error)

    % Check if the plot_error argument is present. If it is not present, it
    % is set to 0 (false - do not plot)
    if nargin < 4
        plot_error = 0;
    end
       
    % Get the number of input columns from the data
    tmp = size(data);
    num_features = tmp(2);
    
    % Get the number of data points in the data
    num_data_points = tmp(1);
    
    % Initialize vector to store the prediction error of every iteration
    error = zeros(iterations,1);
    
    % Always set equal to the max number of iterations. If the perceptron
    % converges, this value will change
    stopping_iteration = iterations;
    
    % Initialize weights vector including w0 for the bias
    weights = zeros(num_features + 1, 1);
    
    % Add bias column to the data
    bias = ones(num_data_points,1);
    data_with_bias = [bias data];
    
    % Initialize actual_response matrix. One column per iteration
    actual_response = zeros(num_data_points, iterations);
    
    % Initialize predicted_classes vector
    predicted_classes = zeros(num_data_points, 1);
    
    % Variable to store previous weights result for comparison purposes
    % between epochs to determine if the perceptron has converged to a
    % solution
    previous_weights = weights;
    
    % Iteration counter
    for i = 1:iterations,          
        
        % Loop through all the inputs
        for j = 1:num_data_points,
            
            % Get the desired class for the current input
            desired_class = class(j);
            
            % Separate the input from the data array
            input = data_with_bias(j,:);
            
            % Get the calculated class from the perceptron
            actual_response(j, i) = sign( weights' * input' );            
           
            % Adjust the weights as needed
            tempro = (learning_rate * ( (desired_class - actual_response(j, i)) .* input ));
            weights = weights + tempro';
        end
        
        % Calculate error
        error(i) = calculate_error(class, actual_response(:,i));
        
        % Only check for difference in epochs after a full first iteration 
        % has completed
        if i > 1,            
            % Terminate is there is not difference between the epochs
            if (isequal(previous_weights, weights))
                
                % The perceptron converged
                stopping_iteration = i;
                
                % The predicted classes are the last response calculated by
                % the perceptron
                predicted_classes = actual_response(:,i);                
                break;
            end
        end 
        
        % Current weights are now old weights
        previous_weights = weights;
    end
    
    % Plot error rate if parameter is set to 1 (true)
    if plot_error == 1        
        figure,hold on
        xlabel('Iterations')
        ylabel('Error')
        title('\it{Prediction error over iterations}')
        plot(1:stopping_iteration, error(1:stopping_iteration));
        hold off
    end
    
end

function [error] = calculate_error(real_class, predicted_class)
   D = abs(real_class-predicted_class).^2;
   error = sum(D(:))/numel(real_class);
end
