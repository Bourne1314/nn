function [ output_args ] = ga_test( )
%GA_TEST Summary of this function goes here
%   Detailed explanation goes here

    result = ga(@ga_test_func, 2);
    result
end

