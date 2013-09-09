function [ weights, diff, weights_alteration ] = train_point( weights, point, rate )
    % 1.0 is the bias
    unlabeled_point = [ 1.0 get_unlabeled(point) ];
    diff = get_class(point) - classify(weights, unlabeled_point);
    weights_alteration = rate * ( diff .* unlabeled_point );
    weights = weights + weights_alteration;
end
