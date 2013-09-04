function [ mse ] = mse_dataset( weights, dataset )
    squared_errors = [];
    for j=dataset',
        point = j';
        err = error_point(weights, point);
        disp(err);
        squared_errors = [ squared_errors err^2 ];
    end
    mse = mean(squared_errors);
end
