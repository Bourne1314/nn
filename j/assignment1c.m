function [ mses ] = assignment1c (data, idx)
    learning_rates = [0.01:0.01:1];
    mses = [];
    for lr=learning_rates,
        [weights stopping_iteration predicted_classes] = perceptron(data, idx, lr, 10, 0)
        curr_mse = calculate_error(idx, predicted_classes);
        mses = [ mses curr_mse];
    end
end

function [error] = calculate_error(real_class, predicted_class)
   D = abs(real_class-predicted_class).^2;
   error = sum(D(:))/numel(real_class);
end
