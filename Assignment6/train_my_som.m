function [ som_trained ] = train_my_som(points, som_untrained, learning_rate)
    
    options = zeros(1,18);
    options(1) = 1; % display error values
    options(5) = 1; % is sampled randomly with replacement
    options(6) = 0; % 1: batch algorithm; 0 (the default): on-line algorithm
    options(14) = 1; % number of iterations
    options(15) = 4; % initial neighborhood
    options(17) = 4; % final neighborhood
    %options(17) = 1; % final neighborhood
    %options(16) = 0.001; % final learning rate
    options(16) = learning_rate; % final learning rate
    options(18) = learning_rate; % initial learning rate
    som_trained = somtrain(som_untrained, options, points);
end

