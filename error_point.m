function [ error ] = error_point( weights, point )
    diff = classify(weights, point) - get_class(point);
    error = abs(diff);
end
