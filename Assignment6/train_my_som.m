function [ som_trained ] = train_my_som(points, som_untrained)
    
    options = zeros(1,18);
    options(1) = 1; % display error values
    options(5) = 1; % is sampled randomly with replacement
    options(6) = 1; % 1: batch algorithm; 0 (the default): on-line algorithm
    options(14) = 100; % number of iterations
    options(15) = 2; % initial neighborhood
    options(17) = 2; % final neighborhood
    %options(17) = 1; % final neighborhood
    %options(16) = 0.001; % final learning rate
    options(16) = 0.2; % final learning rate
    options(18) = 0.2; % initial learning rate
    som_trained = somtrain(som_untrained, options, points);
end

