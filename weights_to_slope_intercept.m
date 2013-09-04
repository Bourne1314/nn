function [ slope intercept ] = weights_to_slope_intercept( weights )
    slope = (-1) * ( weights(2) / weights(3) );
    intercept = (-1) * ( weights(1) / weights(3) );
end

