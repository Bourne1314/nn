function [ result ] = ga_runner( input_args )
%GA_RUNNER Summary of this function goes here
%   Detailed explanation goes here
    result = ga(@ga_func, 2);
    
end

