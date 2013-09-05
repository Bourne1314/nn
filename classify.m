function [ class ] = classify( weights, point )
    prod = weights * [1 point]';
    class = sign( prod );
    %disp([ prod, class ]);
end
