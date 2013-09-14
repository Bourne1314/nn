function [ yy ] = ff(weights, xx)
    [ slope, intercept ] = weights_to_slope_intercept(weights);
    yy = slope * xx + intercept;
end