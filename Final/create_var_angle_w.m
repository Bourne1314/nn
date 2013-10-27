function [ var_angle_w ] = create_var_angle_w( data, angle_of_movement, w )
    var_angle_w = zeros(1,size(angle_of_movement,2));

    for i=2:47,
        w_start = max([1 (i - w)]);
        curr = var(angle_of_movement(w_start:i,:));
        var_angle_w(end+1,:) = curr;
    end
end
