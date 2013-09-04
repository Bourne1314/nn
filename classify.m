function [ class ] = classify( weights, point )
    prod = weights * point';
    class = sign( prod );
    %disp([ prod, class ]);
end
