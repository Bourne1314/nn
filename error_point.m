function [ error ] = error_point( weights, point )
    diff = classify(weights, get_unlabeled(point)) - get_class(point);
    error = abs(diff);
end
